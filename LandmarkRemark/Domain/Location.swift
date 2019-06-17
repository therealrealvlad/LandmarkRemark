//
//  Location.swift
//  LandmarkRemark
//
//  Created by therealrealvlad on 14/6/19.
//  Copyright © 2019 therealrealvlad. All rights reserved.
//

import UIKit

extension Domain {
    /// Represents a location (latitude, longitude) on the map (may be linked to either a User or Note)
    struct Location {
        /// Latitude on the map
        let latitude: Double

        /// Longitude on the map
        let longitude: Double
    }
}
