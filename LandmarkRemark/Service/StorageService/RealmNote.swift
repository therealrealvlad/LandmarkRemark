//
//  RealmNote.swift
//  LandmarkRemark
//
//  Created by therealrealvlad on 17/6/19.
//  Copyright © 2019 therealrealvlad. All rights reserved.
//

import Foundation
import RealmSwift

/// Represents the Realm note model that will host our persisted data
class RealmNote: Object {
    @objc dynamic var itemId: String = UUID().uuidString
    @objc dynamic var message: String = ""
    @objc dynamic var userName: String = ""
    @objc dynamic var latitude: Double = 0.0
    @objc dynamic var longitude: Double = 0.0
    @objc dynamic var timestamp: Date = Date()

    override static func primaryKey() -> String? {
        return "itemId"
    }
}
