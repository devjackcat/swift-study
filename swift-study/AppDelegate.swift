//
//  AppDelegate.swift
//  swift-study
//
//  Created by 永平 on 2020/5/19.
//  Copyright © 2020 永平. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        window = UIWindow(frame: UIScreen.main.bounds)
        let vc = ViewController.instantiateFromStoryboard()
        window?.rootViewController = UINavigationController(rootViewController: vc)
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
        
        AppSetup.shared.setup()
        
        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        print("")
    }
}


