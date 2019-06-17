//
//  DataUser.swift
//  LandmarkRemark
//
//  Created by therealrealvlad on 16/6/19.
//  Copyright © 2019 therealrealvlad. All rights reserved.
//

import Foundation

extension AppData {
    /// Represents the user of the app
    struct User: Codable {
        /// The user's name
        let name: String?

        /// Init from domain layer
        init(name: String) {
            self.name = name
        }

        // MARK: Codable

        enum CodingKeys: String, CodingKey {
            case name
        }

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            name = try container.decode(String.self, forKey: .name)
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(name, forKey: .name)
        }
    }
}
