//
//  HNTabBarController.swift
//  HackerNews
//
//  Created by Antonio Vega on 12/11/21.
//

import UIKit

class HNTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        UITabBar.appearance().tintColor = .systemOrange
        viewControllers = [createHomeVC(), createSettingsVC()]
    }

    func createHomeVC() -> UINavigationController {
        let homeVC = HomeVC()

        homeVC.title = "Home"
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)

        return UINavigationController(rootViewController: homeVC)
    }

    func createSettingsVC() -> UINavigationController {
        let settingsVC = SettingsVC()

        settingsVC.title = "Settings"
        settingsVC.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 1)

        return UINavigationController(rootViewController: settingsVC)
    }
    
}
