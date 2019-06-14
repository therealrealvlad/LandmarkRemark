//
//  MainRouter.swift
//  LandmarkRemark
//
//  Created by therealrealvlad on 14/6/19.
//  Copyright (c) 2019 therealrealvlad. All rights reserved.

import UIKit

protocol MainRouting {
    func routeToMapScene(from rootViewController: UIViewController)
}

final class MainRouter: NSObject, MainRouting {
    // MARK: Routing

    /// Builds the map scene and sets the map view controller on the root view controller
    func routeToMapScene(from rootViewController: UIViewController) {
        let mapViewController = MapBuilder().build()
        if let mapViewController = mapViewController as? UIViewController,
            let rootViewController = rootViewController as? NavigationController {
            rootViewController.setViewControllers([mapViewController], animated: true)
        }
    }
}
