//
//  NavigationController.swift
//  LandmarkRemark
//
//  Created by therealrealvlad on 14/6/19.
//  Copyright © 2019 therealrealvlad. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
    override var shouldAutorotate: Bool {
        return false
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    override func viewDidLoad() {
        setNavigationBarHidden(true, animated: false)
        navigationBar.tintColor = .white
        navigationBar.barStyle = .blackTranslucent
        interactivePopGestureRecognizer?.isEnabled = false
    }
}
