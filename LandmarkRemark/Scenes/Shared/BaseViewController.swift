//
//  BaseViewController.swift
//  LandmarkRemark
//
//  Created by therealrealvlad on 14/6/19.
//  Copyright © 2019 therealrealvlad. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    // Only supporting portrait orientation in the app
    override var shouldAutorotate: Bool {
        return false
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    // Hide the status bar to provide an immersive experience in the map scene
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
