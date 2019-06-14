//
//  MapBuilder.swift
//  LandmarkRemark
//
//  Created by therealrealvlad on 14/6/19.
//  Copyright (c) 2019 therealrealvlad. All rights reserved.

import UIKit

/// Builds the map scene
protocol MapBuilding {
    /// Builds the map scene, returning the scene's view controller to the caller
    func build() -> MapDisplaying
}

final class MapBuilder: MapBuilding {
    // MARK: Build

    func build() -> MapDisplaying {
        let viewController = MapViewController()
        let presenter = MapPresenter(viewController: viewController)
        let worker = MapWorker()
        let router = MapRouter()
        let interactor = MapInteractor(presenter: presenter, worker: worker, router: router)
        viewController.interactor = interactor
        return viewController
    }
}
