//
//  StargazersService.swift
//  StargazersKit
//
//  Created by Roberto Casula on 17/03/22.
//

import Foundation

class StargazersService {

    let networkClient: NetworkClientProtocol

    init(networkClient: NetworkClientProtocol) {
        self.networkClient = networkClient
    }

    func getStargazers(
        repo: String,
        owner: String,
        completion: @escaping (Result<[Stargazer], NetworkError>) -> Void
    ) {
        let request = StargazersRequest(repo: repo, owner: owner)
        networkClient.dataRequest(request, completion: completion)
    }
}
