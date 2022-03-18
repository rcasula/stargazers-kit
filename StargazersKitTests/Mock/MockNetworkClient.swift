//
//  MockNetworkClient.swift
//  StargazersKitTests
//
//  Created by Roberto Casula on 17/03/22.
//

import Foundation

@testable import StargazersKit

class MockNetworkClient: NetworkClientProtocol {

    func dataRequest<R>(
        _ request: R,
        completion: @escaping (Result<R.Response, NetworkError>) -> Void
    ) where R: Request {
        guard
            let url = Bundle(for: type(of: self)).url(
                forResource: "stargazers", withExtension: "json"),
            let data = try? Data(contentsOf: url)
        else {
            completion(.failure(.invalidEndpoint))
            return
        }

        do {
            try completion(.success(request.decode(data)))
        } catch let error {
            completion(.failure(.unknown(error)))
        }
    }
}
