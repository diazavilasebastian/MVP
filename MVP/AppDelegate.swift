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

        

        let navigation = UINavigationController()
        let router = Router(navigation: navigation)
        let presenter = MovielistPresenter(provider: MovieProvider(), router: router)
        let mainViewController = MoviesViewController(presenter: presenter)
        navigation.setViewControllers([mainViewController], animated: false)

        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
        
        return true
    }
}

