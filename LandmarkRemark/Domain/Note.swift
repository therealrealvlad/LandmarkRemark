//
//  Note.swift
//  LandmarkRemark
//
//  Created by therealrealvlad on 14/6/19.
//  Copyright © 2019 therealrealvlad. All rights reserved.
//

import Foundation

extension Domain {
    /// Represents a note created by a user
    struct Note {
        /// A message created by the user
        let message: String

        /// The user who created the note
        let user: User
    }
}
