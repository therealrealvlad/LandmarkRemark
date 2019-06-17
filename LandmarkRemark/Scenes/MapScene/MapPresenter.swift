//
//  MapPresenter.swift
//  LandmarkRemark
//
//  Created by therealrealvlad on 14/6/19.
//  Copyright (c) 2019 therealrealvlad. All rights reserved.

import UIKit

protocol MapPresenting {
    /// Tells the presenter to start tracking the user's location
    func startTrackingUserLocation()

    /// Tells the presenter to show the stored notes
    func show(storedNotes: [Domain.Note])

    /// Tells the presenter that an error occurred while fetching notes
    func show(_ error: Error)
}

final class MapPresenter: MapPresenting {
    // MARK: Properties

    /// The interactor maintains a weak reference to the view controller, thereby preventing a memory retention cycle from forming in the VIP cycle: one of the major advantages of the VIP pattern is that the system's memory allocation for the entire scene is disposed when the view controller is destroyed
    weak var viewController: MapDisplaying?

    // MARK: Lifecycle

    init(viewController: MapDisplaying) {
        self.viewController = viewController
    }

    // MARK: MapPresenting

    func startTrackingUserLocation() {
        viewController?.configureMapView()
    }

    func show(storedNotes: [Domain.Note]) {
        let mappedNotes = storedNotes.map {
            Map.ViewModel.Note(message: $0.message, userName: $0.user.name, location: Map.ViewModel.Note.Location(latitude: $0.location.latitude, longitude: $0.location.longitude))
        }
        viewController?.show(storedNotes: mappedNotes)
    }

    func show(_ error: Error) {
        viewController?.show(error)
    }
}
