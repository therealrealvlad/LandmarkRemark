//
//  MapInteractor.swift
//  LandmarkRemark
//
//  Created by therealrealvlad on 14/6/19.
//  Copyright (c) 2019 therealrealvlad. All rights reserved.

import UIKit

protocol MapInteracting {
    func requestLocationTrackingPermission()
}

protocol MapLocationRequestDelegate: AnyObject {
    func didChangeLocationAuthorizationStatus(status: Domain.LocationTrackingStatus)
}

final class MapInteractor: MapInteracting, MapLocationRequestDelegate {
    // MARK: Properties

    let presenter: MapPresenting
    let locationService: LocationServiceProviding
    let router: MapRouting

    // MARK: Lifecycle

    init(presenter: MapPresenting, locationService: LocationServiceProviding, router: MapRouting) {
        self.presenter = presenter
        self.locationService = locationService
        self.router = router
        // Set the delegate on the location service to receive callbacks when location tracking status changes
        (locationService as? LocationService)?.delegate = self
    }

    // MARK: MapInteracting

    func requestLocationTrackingPermission() {
        locationService.requestLocationTracking()
    }

    // MARK: MapLocationRequestDelegate

    func didChangeLocationAuthorizationStatus(status: Domain.LocationTrackingStatus) {
        if [.authorizedAlways, Domain.LocationTrackingStatus.authorizedWhenInUse, Domain.LocationTrackingStatus.restricted].contains(status) {
            presenter.startTrackingUserLocation()
        } else {
            // TODO: Handle other cases
        }
    }
}
