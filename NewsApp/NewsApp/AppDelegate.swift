//
//  AppDelegate.swift
//  NewsApp
//
//  Created by Sanjeev Pant on 14/07/20.
//  Copyright © 2020 Sanjeev Pant. All rights reserved.
//

import UIKit

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {

    var coordinator:MainCoordinator?
    var window:UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let navigationController = UINavigationController.init()
        coordinator = MainCoordinator.init(navigationController: navigationController)
        
        let isLoggedIn = KeychainWrapper.standard.bool(forKey: "isLoggedIn") ?? false
        
        if isLoggedIn{
            coordinator?.navigateToNewsVC()
        }
        else{
            coordinator?.navigate() 
        }
        
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }

}

