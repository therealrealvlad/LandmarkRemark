//
//  User.swift
//  LandmarkRemark
//
//  Created by therealrealvlad on 14/6/19.
//  Copyright © 2019 therealrealvlad. All rights reserved.
//

import Foundation

/// Represents the user of the app
struct User {
    /// A unique user identifier
    let id: String

    /// The user's first name
    let firstName: String

    /// The user's last name
    let lastName: String

    /// An array of notes linked to this user
    let notes: [Note]
}
