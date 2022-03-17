//
//  StargazersRequest.swift
//  StargazersKit
//
//  Created by Roberto Casula on 17/03/22.
//

import Foundation

struct StargazersRequest: Request {

    typealias Response = [Stargazer]

    private static var baseUrl: String { "https://api.github.com" }
    private static var path: String { "/repos/{owner}/{repo}/stargazers" }

    var method: Method { .get }
    var headers: [String : String] {
        ["Accept": "application/json"]
    }

    var decoder: JSONDecoder {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        return jsonDecoder
    }

    var url: String

    init(repo: String, owner: String) {
        self.url = Self.getUrl(
            for: Self.baseUrl,
            path: Self.path,
            pathParameters: [
                "repo": repo,
                "owner": owner
            ]
        )
    }

    func decode(_ data: Data) throws -> [Stargazer] {
        try decoder.decode(Response.self, from: data)
    }
}
