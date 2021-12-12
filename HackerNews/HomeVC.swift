//
//  HomeVC.swift
//  HackerNews
//
//  Created by Antonio Vega on 12/11/21.
//

import UIKit

class HomeVC: UIViewController {

    var liveDataMode: LiveData = .topstories
    var filterBarButton: UIBarButtonItem!

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
    }

    func configure() {
        view.backgroundColor = .systemBackground

        navigationController?.navigationBar.tintColor = .systemOrange
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = filterBarButton
        navigationItem.title = "Top Stories"
    }

    @objc func filterBarButtonTapped() {
        let actionSheet = UIAlertController(title: "Sort by...", message: nil, preferredStyle: .actionSheet)

        actionSheet.addAction(UIAlertAction(title: "Top Stories", style: .default, handler: { action in
            self.filterBarButton.image = LiveData.topStoriesSFSymbol
            self.liveDataMode = .topstories
            self.navigationItem.title = "Top Stories"
        }))

        actionSheet.addAction(UIAlertAction(title: "Best Stories", style: .default, handler: { action in
            self.filterBarButton.image = LiveData.bestStoriesSFSymbol
            self.liveDataMode = .beststories
            self.navigationItem.title = "Best Stories"
        }))

        actionSheet.addAction(UIAlertAction(title: "New Stories", style: .default, handler: { action in
            self.filterBarButton.image = LiveData.newStoriesSFSymbol
            self.liveDataMode = .newstories
            self.navigationItem.title = "New Stories"
        }))

        actionSheet.addAction(UIAlertAction(title: "Ask HN", style: .default, handler: { action in
            self.filterBarButton.image = LiveData.askStoriesSFSymbol
            self.liveDataMode = .askstories
            self.navigationItem.title = "Ask HN"
        }))

        actionSheet.addAction(UIAlertAction(title: "Show HN", style: .default, handler: { action in
            self.filterBarButton.image = LiveData.showStoriesSFSymbol
            self.liveDataMode = .showstories
            self.navigationItem.title = "Show HN"
        }))

        actionSheet.addAction(UIAlertAction(title: "Jobs", style: .default, handler: { action in
            self.filterBarButton.image = LiveData.jobStoriesSFSymbol
            self.liveDataMode = .jobstories
            self.navigationItem.title = "Jobs"
        }))

        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))

        present(actionSheet, animated: true)
    }
    
}
