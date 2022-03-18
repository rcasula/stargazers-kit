//
//  SecurityTests.swift
//  StargazersKitTests
//
//  Created by Roberto Casula on 17/03/22.
//

import XCTest

@testable import StargazersKit

class SecurityTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func testBundleFailing() {
        let bundle = "test.bundle.identifiertoolong"
        XCTAssertTrue(SecurityService.applicationHasTooLongBundleIdentifier(identifier: bundle))

        let bundle21 = "test.bundle.ide12345x"
        XCTAssertTrue(SecurityService.applicationHasTooLongBundleIdentifier(identifier: bundle21))
    }

    func testBundlePassing() {
        let bundle = "test.bundle.id"
        XCTAssertFalse(SecurityService.applicationHasTooLongBundleIdentifier(identifier: bundle))

        let bundle20 = "test.bundle.ide12345"
        XCTAssertFalse(SecurityService.applicationHasTooLongBundleIdentifier(identifier: bundle20))
    }

    func testIsSimulator() {
        XCTAssertTrue(SecurityService.isRunningInSimulator())
    }

    func testDeviceNotRooted() {
        XCTAssertFalse(SecurityService.isDeviceRooted())
    }

}
