//
//  RequestTests.swift
//  StargazersKitTests
//
//  Created by Roberto Casula on 17/03/22.
//

import XCTest

@testable import StargazersKit

class RequestTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testStargazersRequestUrlReplacing() {
        let request = StargazersRequest(repo: "test", owner: "test1")
        XCTAssertEqual("https://api.github.com/repos/test1/test/stargazers", request.url)
    }

}
