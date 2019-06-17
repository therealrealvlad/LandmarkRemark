//
//  RealmList.swift
//  LandmarkRemark
//
//  Created by therealrealvlad on 17/6/19.
//  Copyright © 2019 therealrealvlad. All rights reserved.
//

import Foundation

import RealmSwift

/// Represents the Realm list model that will host our persisted data
class RealmList: Object {
    @objc dynamic var projectId: String = UUID().uuidString
    @objc dynamic var owner: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var timestamp: Date = Date()

    let notes = List<RealmNote>()

    override static func primaryKey() -> String? {
        return "projectId"
    }
}
