//
//  MapInteractor.swift
//  LandmarkRemark
//
//  Created by therealrealvlad on 14/6/19.
//  Copyright (c) 2019 therealrealvlad. All rights reserved.

import UIKit

protocol MapInteracting {
    /// Requests permission to track the user's location
    func requestLocationTrackingPermission()

    /// Tells the interactor to store a note
    func storeNote(note: Domain.Note)

    /// Tells the interactor to retrieve stored notes
    func retrieveNotes()
}

protocol MapLocationRequestDelegate: AnyObject {
    func didChangeLocationAuthorizationStatus(status: Domain.LocationTrackingStatus)
}

final class MapInteractor: MapInteracting, MapLocationRequestDelegate {
    // MARK: Properties

    let presenter: MapPresenting
    let locationService: LocationServiceProviding
    let storageService: StorageServiceProviding

    // MARK: Lifecycle

    init(presenter: MapPresenting, locationService: LocationServiceProviding, storageService: StorageServiceProviding) {
        self.presenter = presenter
        self.locationService = locationService
        self.storageService = storageService
        // Set the delegate on the location service to receive callbacks when location tracking status changes
        (locationService as? LocationService)?.delegate = self
    }

    // MARK: MapInteracting

    func requestLocationTrackingPermission() {
        locationService.requestLocationTracking()
    }

    func storeNote(note: Domain.Note) {
        storageService.store(note: note)
    }

    func retrieveNotes() {
        storageService.configure { result in
            switch result {
            case let .success(notes):
                self.presenter.show(storedNotes: notes)
            case let .failure(error):
                self.presenter.show(error)
            }
        }
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
