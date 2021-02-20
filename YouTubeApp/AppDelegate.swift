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
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        let layout = UICollectionViewFlowLayout()
        window?.rootViewController =
            UINavigationController(rootViewController:
                                    HomeController(collectionViewLayout: layout)
            )
        
        //        UINavigationBar.appearance().barTintColor = UIColor(red: 230/255,
        //                                                            green: 32/255,
        //                                                            blue: 31/255,
        //                                                            alpha: 1)
        
        UINavigationBar.appearance().barTintColor = UIColor.getRgb(red: 230,
                                                                   green: 32,
                                                                   blue: 31)
        
        //get rid of black bar underneath navBar
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().setBackgroundImage(UIImage(),
                                                        for: .default)
        
        let statusBarBackgroundColor = UIView()
        statusBarBackgroundColor.backgroundColor = UIColor.getRgb(red: 194,
                                                                  green: 31,
                                                                  blue: 31)
        
        window?.addSubview(statusBarBackgroundColor)
        window?.addConstraintsWithFormat(format: "H:|[v0]|",
                                         views: [statusBarBackgroundColor])
        window?.addConstraintsWithFormat(format: "V:|[v0(20)]", views: [statusBarBackgroundColor])
        // ? На 11 айфоне полная лажа - нужно отдельно для старых 20! А для свежих 35!
        // Понять как изменить!
        
        return true
    }
}

