//
//  AppDelegate.swift
//  RupeshContactsApp
//
//  Created by rupesh on 06/05/20.
//  Copyright © 2020 rupesh. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        if #available(iOS 13, *){
            //For devices above iOS 13 app launch is handled by SceneDelegate
        }else{
            //Set MainViewController as window's rootViewController
            window = UIWindow(frame: UIScreen.main.bounds)
            let mainVc = MainTabViewController()
            window?.rootViewController = mainVc
            window?.makeKeyAndVisible()
        }
        return true
    }

}

//Extension available only for IOs 13+ devices to support multiple windows in future
@available(iOS 13, *)
extension AppDelegate{
    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}
