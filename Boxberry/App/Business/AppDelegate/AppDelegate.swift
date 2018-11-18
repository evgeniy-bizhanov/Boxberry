//
//  AppDelegate.swift
//  Boxberry
//
//  Created by Евгений Бижанов on 16/11/2018.
//  Copyright © 2018 Евгений Бижанов. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        window?.makeKeyAndVisible()
        
        let vc = UIStoryboard(name: "Points", bundle: nil).instantiateInitialViewController()
        window?.rootViewController = vc
        
        return true
    }

}
