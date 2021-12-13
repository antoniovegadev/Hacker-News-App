//
//  HomeVC.swift
//  HackerNews
//
//  Created by Antonio Vega on 12/11/21.
//

import UIKit

class HomeVC: UIViewController {

    var filterBarButton: UIBarButtonItem!

    let tableView = UITableView()
    var items: [Item] = []

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        self.filterBarButton = UIBarButtonItem(
            image: LiveData.topStoriesSFSymbol,
            style: .plain,
            target: self,
            action: #selector(filterBarButtonTapped)
        )
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        configureTableView()
        getItems(for: .topstories)
    }

    func configure() {
        view.backgroundColor = .systemBackground

        navigationController?.navigationBar.tintColor = .systemOrange
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = filterBarButton
        navigationItem.title = "Top Stories"
    }

    func configureTableView() {
        view.addSubview(tableView)

        tableView.frame = view.bounds
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 120
        tableView.delegate = self
        tableView.dataSource = self

        tableView.layoutMargins = UIEdgeInsets.zero
        tableView.separatorInset = UIEdgeInsets.zero

        tableView.register(HNItemCell.self, forCellReuseIdentifier: HNItemCell.reuseID)
    }

    func getItems(for filter: LiveData) {
        Task {
            do {
                let ids = try await NetworkManager.shared.fetchLiveData(filter: filter)
                let items = try await NetworkManager.shared.fetchItems(ids: ids)
                updateUI(with: items)
            } catch {
                print("There was an error")
            }
        }
    }

    func updateUI(with items: [Item]) {
        self.items = items
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    @objc func filterBarButtonTapped() {
        let actionSheet = UIAlertController(title: "Sort by...", message: nil, preferredStyle: .actionSheet)

        actionSheet.addAction(UIAlertAction(title: "Top Stories", style: .default, handler: { action in
            self.filterBarButton.image = LiveData.topStoriesSFSymbol
            self.getItems(for: .topstories)
            self.navigationItem.title = "Top Stories"
        }))

        actionSheet.addAction(UIAlertAction(title: "Best Stories", style: .default, handler: { action in
            self.filterBarButton.image = LiveData.bestStoriesSFSymbol
            self.getItems(for: .beststories)
            self.navigationItem.title = "Best Stories"
        }))

        actionSheet.addAction(UIAlertAction(title: "New Stories", style: .default, handler: { action in
            self.filterBarButton.image = LiveData.newStoriesSFSymbol
            self.getItems(for: .newstories)
            self.navigationItem.title = "New Stories"
        }))

        actionSheet.addAction(UIAlertAction(title: "Ask HN", style: .default, handler: { action in
            self.filterBarButton.image = LiveData.askStoriesSFSymbol
            self.getItems(for: .askstories)
            self.navigationItem.title = "Ask HN"
        }))

        actionSheet.addAction(UIAlertAction(title: "Show HN", style: .default, handler: { action in
            self.filterBarButton.image = LiveData.showStoriesSFSymbol
            self.getItems(for: .showstories)
            self.navigationItem.title = "Show HN"
        }))

        actionSheet.addAction(UIAlertAction(title: "Jobs", style: .default, handler: { action in
            self.filterBarButton.image = LiveData.jobStoriesSFSymbol
            self.getItems(for: .jobstories)
            self.navigationItem.title = "Jobs"
        }))

        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))

        present(actionSheet, animated: true)
    }
    
}


extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HNItemCell.reuseID) as! HNItemCell
        let item = items[indexPath.row]
        cell.set(item: item)
        cell.layoutMargins = UIEdgeInsets.zero
        return cell
    }
}