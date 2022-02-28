//
//  MainTabViewController.swift
//  RupeshContactsApp
//
//  Created by rupesh on 03/06/20.
//  Copyright © 2020 rupesh. All rights reserved.
//

import UIKit

class MainTabViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //add tab Items
        addTabItems()
    }

    ///Method to add items to MainTabViewController
    private func addTabItems(){
        self.tabBar.isTranslucent = false
        //self.tabBar.barTintColor = .blue
        self.tabBar.tintColor = .red
        self.tabBar.unselectedItemTintColor = .gray

        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font : UIFont(name: "Helvetica Neue", size: 12)! , NSAttributedString.Key.foregroundColor: UIColor.gray], for: [.normal])
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font : UIFont(name: "Helvetica Neue", size: 12)!, NSAttributedString.Key.foregroundColor:UIColor.blue], for: [.selected])

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
