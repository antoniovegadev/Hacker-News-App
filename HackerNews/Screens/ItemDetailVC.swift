//
//  ItemDetailVC.swift
//  HackerNews
//
//  Created by Antonio Vega on 12/14/21.
//

import UIKit

class ItemDetailVC: HNDataLoadingVC {

    var item: Item!

    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        configureTableView()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        guard let headerView = tableView.tableHeaderView else {
            return
        }

        let size = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)

        if headerView.frame.size.height != size.height {
            headerView.frame.size.height = size.height
            tableView.tableHeaderView = headerView
            tableView.layoutIfNeeded()
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
//        tableView.dataSource = self
        tableView.frame = view.bounds
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 120

        tableView.tableHeaderView = HNTableHeader(item: item)
    }
}

extension ItemDetailVC: UIScrollViewDelegate, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        return
//    }

}
