//
//  StargazersKitTests.swift
//  StargazersKitTests
//
//  Created by Roberto Casula on 16/03/22.
//

import XCTest

@testable import StargazersKit

class StargazersKitTests: XCTestCase {

    override func setUpWithError() throws {
        StargazersApp.configure(
            bundleIdentifier: "dev.casula.tests",
            networkClient: MockNetworkClient()
        )
    }

    func testFull() {
        let didReceiveResponse = expectation(description: #function)

        var stargazers: [Stargazer] = []
        StargazersApp.shared.stargazers(
            for: "GRDB.swift", owner: "groue"
        ) { result in
            switch result {
            case .success(let res):
                stargazers = res
                didReceiveResponse.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }

        wait(for: [didReceiveResponse], timeout: 5)

        XCTAssertGreaterThan(stargazers.count, 0, "Stargazers are empty")
    }
}
