//
//  LocationService.swift
//  LandmarkRemark
//
//  Created by therealrealvlad on 14/6/19.
//  Copyright © 2019 therealrealvlad. All rights reserved.
//

import CoreLocation
import Foundation

/// Controls the user location tracking state
protocol LocationServiceProviding {
    /// Requests location tracking authorization from the user
    func requestLocationTracking()
}

final class LocationService: NSObject, LocationServiceProviding, CLLocationManagerDelegate {
    // MARK: Properties

    let locationManager = CLLocationManager()
    weak var delegate: MapLocationRequestDelegate?
    var locationTrackingStatus: Domain.LocationTrackingStatus = .denied

    // MARK: Lifecycle

    override init() {
        super.init()
        locationManager.delegate = self
    }

    // MARK: LocationServiceProviding

    func requestLocationTracking() {
        locationManager.requestWhenInUseAuthorization()
    }

    func startTrackingUser() {
        locationManager.startUpdatingLocation()
    }

    func stopTrackingUser() {
        locationManager.stopUpdatingLocation()
    }

    // MARK: CLLocationManagerDelegate

    func locationManager(_: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        delegate?.didChangeLocationAuthorizationStatus(status: mapToDomainLocationTrackingStatus(from: status))
    }

    // MARK: Private helpers

    private func mapToDomainLocationTrackingStatus(from status: CLAuthorizationStatus) -> Domain.LocationTrackingStatus {
        switch status {
        case .notDetermined:
            return .notDetermined
        case .restricted:
            return .restricted
        case .denied:
            return .denied
        case .authorizedAlways:
            return .authorizedAlways
        case .authorizedWhenInUse:
            return .authorizedWhenInUse
        @unknown default:
            return .denied
        }
    }
}
