//
//  MapViewController.swift
//  LandmarkRemark
//
//  Created by therealrealvlad on 14/6/19.
//  Copyright (c) 2019 therealrealvlad. All rights reserved.

import MapKit
import UIKit

protocol MapDisplaying: AnyObject {
    func display(viewModel: Map.ViewModel)
}

final class MapViewController: UIViewController, MapDisplaying {
    // MARK: Outlets

    @IBOutlet var mapView: MKMapView!

    // MARK: Properties

    var interactor: MapInteracting!

    // Hide the status bar to provide an immersive experience in the map scene
    override var prefersStatusBarHidden: Bool {
        return true
    }

    // MARK: Lifecycle

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: Displaying

    func display(viewModel _: Map.ViewModel) {}
}
