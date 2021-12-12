//
//  SettingsVC.swift
//  HackerNews
//
//  Created by Antonio Vega on 12/11/21.
//

import UIKit

class SettingsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
    }

    func configure() {
        view.backgroundColor = .systemBackground

        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
