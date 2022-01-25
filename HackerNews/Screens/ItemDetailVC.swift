//
//  ItemDetailVC.swift
//  HackerNews
//
//  Created by Antonio Vega on 12/14/21.
//

import UIKit
import SafariServices
import SwiftSoup

class ItemDetailVC: HNDataLoadingVC {

    var item: Item!

    let tableView = UITableView()
    var items = [Item]()

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        configureTableView()
        getComments()

        do {
            let html: String = "<p>An <a href='https://youtube.com/'><b>example</b></a> link.</p>"
            let doc: Document = try SwiftSoup.parse(html)
            let link: Element = try doc.select("a").first()!

            let text: String = try doc.body()!.text()
            let linkHref: String = try link.attr("href")
            let linkText: String = try link.text()

            print(text, linkHref, linkText, separator: " | ")
        } catch Exception.Error(_, let message) {
            print(message)
        } catch {
            print("error")
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        guard let headerView = tableView.tableHeaderView else {
            return
        }

        let size = headerView.systemLayoutSizeFitting(CGSize(width: tableView.bounds.width, height: 0))

        if headerView.frame.size.height != size.height {
            headerView.frame.size.height = size.height
            tableView.tableHeaderView = headerView
            tableView.layoutIfNeeded()
        }
    }

    func getComments() {
        guard let ids = item.kids else { return }

        showLoadingView()

        Task {
            do {
                let items = try await NetworkManager.shared.fetchItems(ids: ids)
                updateUI(with: items)
                dismissLoadingView()
            } catch {
                print("There was an error")
                dismissLoadingView()
            }
        }
    }

    func updateUI(with items: [Item]) {
        self.items = items
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    private func configure() {
        view.backgroundColor = .systemBackground

        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = item.wrappedDescendants.toStringCommentCount()
    }

    private func configureTableView() {
        view.addSubview(tableView)

        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200

        tableView.layoutMargins = UIEdgeInsets.zero
        tableView.separatorInset = UIEdgeInsets.zero

        tableView.tableHeaderView = HNTableHeader(item: item)
        tableView.register(HNCommentCell.self, forCellReuseIdentifier: HNCommentCell.reuseID)
    }
}

extension ItemDetailVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HNCommentCell.reuseID) as! HNCommentCell
        let item = items[indexPath.row]
        cell.set(item: item)
        cell.commentTextLabel.delegate = self
        cell.layoutMargins = UIEdgeInsets.zero
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ItemDetailVC: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        let safariVC = SFSafariViewController(url: URL)
        safariVC.preferredControlTintColor = .systemOrange
        present(safariVC, animated: true)

        return false
    }
}
