//
//  AppDelegate.swift
//  Lection 19
//
//  Created by Kirill Magerya on 08.06.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let mainViewController = MainScreenViewController()
        let navigationViewController = UINavigationController(rootViewController: mainViewController)
        
        window?.rootViewController = navigationViewController
        window?.makeKeyAndVisible()
        
        return true
    }
}

