//
//  ItemDetailVC.swift
//  HackerNews
//
//  Created by Antonio Vega on 12/14/21.
//

import UIKit
import SafariServices
import SwiftSoup
import SkeletonView

class ItemDetailVC: UIViewController {

    var item: Item!

    let tableView = UITableView()
    var items = [Item]()

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()

        tableView.isSkeletonable = true

        configureTableView()
        getComments()
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

    func getChildrenComments(for comment: inout Item) async -> [Item]? {
        do {
            guard let commentIds = comment.kids else { return nil }
            var comments = try await NetworkManager.shared.fetchItems(ids: commentIds)

            for i in 0..<comments.count {
                comments[i].children = await getChildrenComments(for: &comments[i])
            }

            comment.children = comments

            return comments
        } catch {
            print("Recursive - Fetching comments failed.")
            return nil
        }
    }

    func getComments() {
        guard let ids = item.kids else { return }

        tableView.showAnimatedGradientSkeleton()

        Task {
            do {
                print("Fetching comments for item \(item.id)")
                var items = try await NetworkManager.shared.fetchItems(ids: ids)
                for i in 0..<items.count {
                    items[i].children = await getChildrenComments(for: &items[i])
                }
                self.item.children = items
                var comments = [Item]()
                flattenChildren(for: self.item, array: &comments)
                updateUI(with: comments)
                tableView.stopSkeletonAnimation()
                view.hideSkeleton()
            } catch {
                print("There was an error")
                tableView.stopSkeletonAnimation()
                view.hideSkeleton()
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
        navigationItem.title = item.wrappedCommentCount.toStringCommentCount()
    }

    private func configureTableView() {
        view.addSubview(tableView)

        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 150

        tableView.layoutMargins = UIEdgeInsets.zero
        tableView.separatorInset = UIEdgeInsets.zero

        tableView.tableHeaderView = HNTableHeader(item: item)
        tableView.register(HNCommentCell.self, forCellReuseIdentifier: HNCommentCell.reuseID)
    }

    func flattenChildren(for item: Item, array: inout [Item]) {
        if item.type == "comment" {
            array.append(item)
        }

        for child in item.children ?? [] {
            flattenChildren(for: child, array: &array)
        }
    }
}

extension ItemDetailVC: SkeletonTableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return HNCommentCell.reuseID
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
