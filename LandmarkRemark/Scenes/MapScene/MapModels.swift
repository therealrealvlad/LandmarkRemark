//
//  MapModels.swift
//  LandmarkRemark
//
//  Created by therealrealvlad on 14/6/19.
//  Copyright (c) 2019 therealrealvlad. All rights reserved.

import MapKit
import UIKit

/// Represents the namespace for all models related to the map scene
enum Map {
    /// Represents the view model for the map scene
    struct ViewModel {
        /// Represents the annotation view model for the map scene
        final class Annotation: NSObject, MKAnnotation {
            /// Required coordinate of the annotation
            let coordinate: CLLocationCoordinate2D

            /// Optional title for the annotation
            let title: String?

            /// Optional subtitle for the annotation
            let subtitle: String?

            /// Init with required coordinate and optional title/subtitle
            init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String) {
                self.coordinate = coordinate
                self.title = title
                self.subtitle = subtitle
            }
        }

        /// Represents the note view model for the map scene
        struct Note {
            /// Message created by the user
            let message: String

            /// A user name
            let userName: String

            /// The location (latitude, longitude) of the note
            struct Location {
                let latitude: Double
                let longitude: Double
            }

            let location: Location?
        }
    }
}
