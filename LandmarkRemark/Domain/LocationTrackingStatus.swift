//
//  LocationTrackingStatus.swift
//  LandmarkRemark
//
//  Created by therealrealvlad on 14/6/19.
//  Copyright © 2019 therealrealvlad. All rights reserved.
//

import Foundation

extension Domain {
    /// Provides a convenient domain-level representation of the various authorization states of the location tracking service
    enum LocationTrackingStatus {
        case notDetermined, restricted, denied, authorizedAlways, authorizedWhenInUse
    }
}
