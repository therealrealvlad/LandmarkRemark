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
        struct Annotation {
            let coordinate: CLLocationCoordinate2D
            let title: String?
            let subtitle: String?
        }
    }
}
