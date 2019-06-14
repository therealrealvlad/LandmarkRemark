//
//  AppDelegate.swift
//  LandmarkRemark
//
//  Created by therealrealvlad on 14/6/19.
//  Copyright © 2019 therealrealvlad. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        window.rootViewController = BaseViewController()
        window.makeKeyAndVisible()
        let router = MainRouter()
        guard let rootViewController = window.rootViewController else {
            fatalError("Root view controller was not set on main window")
        }
        router.routeToMapScene(from: rootViewController)
        return true
    }
}
