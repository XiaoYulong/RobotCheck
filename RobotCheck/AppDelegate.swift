//
//  AppDelegate.swift
//  RobotCheck
//
//  Created by yuxiao on 2020/12/31.
//  Copyright © 2020 Yulong Xiao. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        let vc = AnimationViewController()
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        return true
    }
}

