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
    var mapViewController: MapDisplaying?
    let mapInteractorSpy = MapInteractorSpy()

    override func setUp() {
        mapViewController = MapBuilder().build()
    }

    func test_didRequestLocationTrackingPermission_whenMapViewControllerDidLoad() {
        let viewController = mapViewController as? UIViewController

        // when
        _ = viewController?.view

        // then
        mapInteractorSpy.requestLocationTrackingPermission()
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
