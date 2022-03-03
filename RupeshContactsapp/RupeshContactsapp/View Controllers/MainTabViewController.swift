//
//  MainTabViewController.swift
//  RupeshContactsApp
//
//  Created by rupesh on 03/06/20.
//  Copyright © 2020 rupesh. All rights reserved.
//

import UIKit

///MainTabViewController of the app
///Contains all the tabs required for the app
class MainTabViewController: UITabBarController {

    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //add tab Items
        setTabBar()
    }

    ///Method to setTabBar
    private func setTabBar(){

        self.tabBar.isTranslucent = false
        self.tabBar.tintColor = AppColors.tabBarTintColor
        self.tabBar.unselectedItemTintColor = .gray

        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font : UIFont(name: "Helvetica Neue", size: 12)! , NSAttributedString.Key.foregroundColor: UIColor.gray], for: [.normal])
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font : UIFont(name: "Helvetica Neue", size: 12)!, NSAttributedString.Key.foregroundColor:AppColors.tabBarTintColor], for: [.selected])

        let contactListController = ContactListController()
        let settingsController = SettingsController()

        let contactListTabItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 0)
        let settingsTabItem = UITabBarItem(tabBarSystemItem: .more, tag: 1)

        contactListController.tabBarItem    =   contactListTabItem
        settingsController.tabBarItem       =   settingsTabItem

        let tabControllers: [UIViewController] = [contactListController, settingsController]

        self.viewControllers = tabControllers.map { let aController = UINavigationController(rootViewController: $0)
            aController.view.backgroundColor = .white
            return aController
        }
    }

}
