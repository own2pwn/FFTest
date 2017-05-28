//
//  AppDelegate.swift
//  FFTest
//
//  Created by Francisco Amado on 26/05/2017.
//  Copyright © 2017 franciscoamado. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = NavigationController(rootViewController: MainViewController())
        
        return true
    }
}
