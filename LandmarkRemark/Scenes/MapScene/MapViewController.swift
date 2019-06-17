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

    /// Shows stored notes on the map view
    func show(storedNotes: [Map.ViewModel.Note])

    /// Shows the user an error message
    func showErrorMessage()
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
        interactor.retrieveNotes()
    }

    // MARK: MapDisplaying

    func configureMapView() {
        mapView.setUserTrackingMode(.follow, animated: true)
        addNoteButton.layer.cornerRadius = ButtonStyle.cornerRadius
        addNoteButton.isHidden = false
    }

    func show(storedNotes: [Map.ViewModel.Note]) {
        storedNotes.forEach {
            if let noteLocation = $0.location {
                let location = CLLocation(latitude: noteLocation.latitude, longitude: noteLocation.longitude)
                self.addAnnotation(at: location, with: $0.message, $0.userName)
            }
        }
    }

    func showErrorMessage() {
        // Note: in a real app, we would want to use StringKey localization together with the .strings file to encapsulate error messages
        let alertController = UIAlertController(title: "A problem occurred", message: "We were unable to retrieve any notes", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }

    // MARK: Private helpers

    private func mapToDomain(from location: CLLocation) -> Domain.Location {
        return Domain.Location(latitude: Double(location.coordinate.latitude), longitude: Double(location.coordinate.longitude))
    }

    private func configureNoteView() {
        let noteView = NoteView.loadView()
        noteView.configure(with: { [weak self] note in
            guard let self = self,
                let note = note else {
                return
            }
            if let location = self.mapView.userLocation.location {
                // Add the note annotation to the map view
                self.addAnnotation(at: location, with: note.message, note.userName)

                // Store the note via the interactor
                self.interactor.storeNote(note: Domain.Note(message: note.message, user: Domain.User(name: note.userName), location: Domain.Location(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)))
            } else {
                // TODO: show user an error indicating that a note cannot be created without location data
            }
        })
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

    private func addAnnotation(at location: CLLocation, with message: String, _ userName: String) {
        let annotation = Map.ViewModel.Annotation(coordinate: location.coordinate, title: message, subtitle: userName)
        mapView.addAnnotation(annotation)
    }

    // MARK: MKMapViewDelegate

    func mapView(_: MKMapView, viewFor _: MKAnnotation) -> MKAnnotationView? {
        return nil
    }
}
