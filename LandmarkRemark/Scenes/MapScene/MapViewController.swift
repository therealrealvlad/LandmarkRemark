//
//  MapViewController.swift
//  LandmarkRemark
//
//  Created by therealrealvlad on 14/6/19.
//  Copyright (c) 2019 therealrealvlad. All rights reserved.

import MapKit
import UIKit

protocol MapDisplaying: AnyObject {
    /// Configures the map view when user tracking state permits
    func configureMapView()
}

final class MapViewController: UIViewController, MapDisplaying, MKMapViewDelegate {
    // MARK: Outlets

    @IBOutlet var mapView: MKMapView!
    @IBOutlet var addNoteButton: UIButton!

    // MARK: Actions

    @IBAction func didTapAddNote(_: UIButton) {
        configureNoteView()
    }

    // MARK: Properties

    var interactor: MapInteracting!
    var currentLocation: Domain.Location?

    // MARK: Override properties

    // Hide the status bar to provide an immersive experience in the map scene
    override var prefersStatusBarHidden: Bool {
        return true
    }

    // MARK: Constants

    enum ButtonStyle {
        static let cornerRadius: CGFloat = 5
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
        mapView.delegate = self
        interactor.requestLocationTrackingPermission()
    }

    // MARK: MapDisplaying

    func configureMapView() {
        mapView.setUserTrackingMode(.follow, animated: true)
        addNoteButton.layer.cornerRadius = ButtonStyle.cornerRadius
        addNoteButton.isHidden = false
    }

    // MARK: Private helpers

    private func mapToDomain(from location: CLLocation) -> Domain.Location {
        return Domain.Location(latitude: Double(location.coordinate.latitude), longitude: Double(location.coordinate.longitude))
    }

    private func configureNoteView() {
        let noteView = NoteView.loadView()
        noteView.configure(with: { [weak self] note in self?.addAnnotation(for: note) })
        noteView.translatesAutoresizingMaskIntoConstraints = false
        mapView.addSubview(noteView)
        noteView.leadingAnchor.constraint(equalTo: mapView.leadingAnchor).isActive = true
        noteView.trailingAnchor.constraint(equalTo: mapView.trailingAnchor).isActive = true
        noteView.topAnchor.constraint(equalTo: mapView.topAnchor).isActive = true
        noteView.heightAnchor.constraint(equalTo: mapView.heightAnchor, multiplier: 0.25).isActive = true
        noteView.alpha = 0.0
        UIView.animate(withDuration: 0.3) {
            noteView.alpha = 1.0
        }
    }

    private func addAnnotation(for note: Map.ViewModel.Note?) {
        if let location = mapView.userLocation.location,
            let note = note {
            let annotation = Map.ViewModel.Annotation(coordinate: location.coordinate, title: note.message, subtitle: note.userName)
            currentLocation = mapToDomain(from: location)
            mapView.addAnnotation(annotation)
        }
    }

    // MARK: MKMapViewDelegate

    func mapView(_: MKMapView, viewFor _: MKAnnotation) -> MKAnnotationView? {
        return nil
    }
}
