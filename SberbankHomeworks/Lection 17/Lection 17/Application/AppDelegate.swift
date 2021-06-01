//
//  AppDelegate.swift
//  Lection 17
//
//  Created by Kirill Magerya on 01.06.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let networkService = ItunesNetworkService()
        let mainVC = MainViewController(networkService: networkService)
        let navigationVC = UINavigationController(rootViewController: mainVC)
        
        window?.rootViewController = navigationVC
        window?.makeKeyAndVisible()
        
        return true
    }
}

