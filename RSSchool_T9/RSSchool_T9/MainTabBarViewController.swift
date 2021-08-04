//
//  MainTabBarViewController.swift
//  RSSchool_T9
//
//  Created by Нехай Роман 8/4/21.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    let images = ["square.grid.2x2","gear"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()
    }
    
    
    func configureTabBar (){
        let homeVC = HomeCollectionViewController()
        let rootViewController = SettingsViewController()
        let settingsVC = UINavigationController(rootViewController: rootViewController)
        rootViewController.state = homeVC.state
        homeVC.title = "Home"
        settingsVC.title = "Settings"
        tabBar.barTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        tabBar.tintColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
        self.setViewControllers([homeVC,settingsVC], animated: true)
        guard let items = self.tabBar.items else {
            return
        }
        for i in 0..<items.count{
            items[i].image = UIImage(systemName: images[i])
        }
    }

}
