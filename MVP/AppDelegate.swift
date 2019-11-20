//
//  AppDelegate.swift
//  MVP
//
//  Created by ITAU on 04-11-19.
//  Copyright © 2019 ITAU. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)

        
        let mainViewController = MoviesViewController()
        let navigation = UINavigationController(rootViewController: mainViewController)

        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
        
        return true
    }
}

