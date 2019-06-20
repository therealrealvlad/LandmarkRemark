//
//  LandmarkRemarkTests.swift
//  LandmarkRemarkTests
//
//  Created by therealrealvlad on 14/6/19.
//  Copyright © 2019 therealrealvlad. All rights reserved.
//

@testable import LandmarkRemark
import XCTest

class LandmarkRemarkTests: XCTestCase {
    let mapViewController = MapViewController()
    let mapInteractorSpy = MapInteractorSpy()

    override func setUp() {
        mapViewController.interactor = mapInteractorSpy
    }

    func test_didRequestLocationTrackingPermission_whenMapViewControllerDidLoad() {
        // when
        _ = mapViewController.view

        // then
        XCTAssertTrue(mapInteractorSpy.didRequestLocationTrackingPermission)
    }

    class MapInteractorSpy: MapInteracting {
        var didRequestLocationTrackingPermission: Bool = false

        func requestLocationTrackingPermission() {
            didRequestLocationTrackingPermission = true
        }

        func storeNote(note _: Domain.Note) {}
        func retrieveNotes() {}
    }
}
