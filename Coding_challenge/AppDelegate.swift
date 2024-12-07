//
//  AppDelegate.swift
//  Coding_challenge
//
//  Created by Dung-pc on 04/12/2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        
        let mainVC = MainViewController()
//        let mainVC = DetailsViewController(id: "bitcoin")
        let navController = UINavigationController(rootViewController: mainVC)
        
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        
        return true
    }
}

