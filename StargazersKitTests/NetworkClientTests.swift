//
//  NetworkClientTests.swift
//  StargazersKitTests
//
//  Created by Roberto Casula on 17/03/22.
//

import XCTest

@testable import StargazersKit

class NetworkClientTests: XCTestCase {

    var networkClient: NetworkClientProtocol?

    override func setUpWithError() throws {
        networkClient = MockNetworkClient()
    }

    func testSuccessfullDecoding() throws {
        let didReceiveResponse = expectation(description: #function)

        var response: [Stargazer] = []
        let request = StargazersRequest(repo: "test", owner: "test1")
        networkClient?.dataRequest(
            request,
            completion: { result in
                switch result {
                case .success(let stargazers):
                    response = stargazers
                    didReceiveResponse.fulfill()
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                }
            })

        wait(for: [didReceiveResponse], timeout: 1)

        XCTAssertGreaterThan(response.count, 0, "Stargazers are empty")
    }

}
