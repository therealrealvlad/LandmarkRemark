//
//  Note.swift
//  LandmarkRemark
//
//  Created by therealrealvlad on 16/6/19.
//  Copyright © 2019 therealrealvlad. All rights reserved.
//

import Foundation

extension AppData {
    /// Represents a note created by a user
    struct Note: Codable {
        /// A message created by the user
        let message: String?

        /// The user who created the note
        let user: User?

        /// Init from domain layer
        init(message: String, user: User) {
            self.message = message
            self.user = user
        }

        // MARK: Codable

        enum CodingKeys: String, CodingKey {
            case message
            case user
        }

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            message = try container.decode(String.self, forKey: .message)
            user = try container.decode(User.self, forKey: .user)
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(message, forKey: .message)
            try container.encode(user, forKey: .user)
        }
    }
}
