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

class MainRouter: NSObject, MainRouting {
    // MARK: Routing

    func routeToMapScene(from rootViewController: UIViewController) {
        let mapViewController = MapBuilder().build()
        if let mapViewController = mapViewController as? UIViewController {
            rootViewController.present(mapViewController, animated: true, completion: nil)
        }
    }
}
