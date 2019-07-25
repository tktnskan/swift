//
//  AppDelegate.swift
//  barcode
//
//  Created by Jinyung Yoon on 23/07/2019.
//  Copyright © 2019 Jinyung Yoon. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        
        window?.rootViewController = HomeViewController()
        
        window?.backgroundColor = UIColor.white

        
        window?.makeKeyAndVisible()
        
        return true
    }
}
