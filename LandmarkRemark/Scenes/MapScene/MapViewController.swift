//
//  MapViewController.swift
//  LandmarkRemark
//
//  Created by therealrealvlad on 14/6/19.
//  Copyright (c) 2019 therealrealvlad. All rights reserved.

import MapKit
import UIKit

protocol MapDisplaying: AnyObject {
    func displayUserLocation()
}

final class MapViewController: UIViewController, MapDisplaying, MKMapViewDelegate {
    // MARK: Outlets

    @IBOutlet var mapView: MKMapView!

    // MARK: Properties

    var interactor: MapInteracting!
    var currentLocation: Domain.Location?

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
        interactor.requestLocationTrackingPermission()
    }

    // MARK: MapDisplaying

    func displayUserLocation() {
        mapView.setUserTrackingMode(.follow, animated: true)
        if let location = mapView.userLocation.location {
            currentLocation = userLocation(from: location)
//            let note = Domain.Note(message: "He there", user: Domain.User(name: "Bob"))
//            if let annotation = Map.ViewModel.Annotation(coordinate: location.coordinate, title: note.message, subtitle: note.user.name) as MKAnnotation {
//                mapView.addAnnotation(annotation)
//            }
        }
    }

    // MARK: Private helpers

    private func userLocation(from location: CLLocation) -> Domain.Location {
        return Domain.Location(latitude: Double(location.coordinate.latitude), longitude: Double(location.coordinate.longitude))
    }

    // MARK: MKMapViewDelegate

    func mapView(_: MKMapView, viewFor _: MKAnnotation) -> MKAnnotationView? {
        return nil
    }
}
