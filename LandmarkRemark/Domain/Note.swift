//
//  Note.swift
//  LandmarkRemark
//
//  Created by therealrealvlad on 14/6/19.
//  Copyright © 2019 therealrealvlad. All rights reserved.
//

import Foundation

/// Represents a note created by a user
struct Note {
    /// The note's title, created by the user
    let title: String

    /// A message created by the user
    let message: String

    /// A date the message was created by the user
    let creationDate: Date

    /// The user who created the note
    let user: User
}
