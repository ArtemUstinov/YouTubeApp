//
//  AppDelegate.swift
//  YouTubeApp
//
//  Created by Артём Устинов on 13.01.2021.
//  Copyright © 2021 Artem Ustinov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        let layout = UICollectionViewFlowLayout()
        window?.rootViewController =
            UINavigationController(rootViewController:
                HomeController(collectionViewLayout: layout)
        )
        
        UINavigationBar.appearance().barTintColor = UIColor(red: 230/255,
                                                            green: 32/255,
                                                            blue: 31/255,
                                                            alpha: 1)
        
        return true
    }
}

