//
//  StargazersKit.swift
//  
//
//  Created by Roberto Casula on 16/03/22.
//

import Foundation

public class StargazersKit {

    public static var shared: StargazersKit {
        guard isSetupDone, let sharedInstance = _shared else {
            fatalError("[StargazersKit] ERROR: You must call `StargazersKit.configure()` first.")
        }
        return sharedInstance
    }

    private static var _shared: StargazersKit?
    private static var isSetupDone: Bool = false

    private var stargazersService: StargazersService

    private init(stargazersService: StargazersService) {
        self.stargazersService = stargazersService
    }

    /// <#Description#>
    public class func configure() {
        configure(networkClient: StandardNetworkClient())
    }

    class func configure(networkClient: NetworkClientProtocol) {
        guard !isSetupDone else { return }
        _shared = .init(
            stargazersService: .init(networkClient: networkClient)
        )
        isSetupDone = true
    }


    //    public func stargazers(for repository: String, owner: String) async throws -> [Stargazer] {
    //        fatalError()
    //    }

    public func stargazers(
        for repository: String,
        owner: String,
        completion: @escaping (Result<[Stargazer], StargazerError>) -> Void
    ) {
        stargazersService.getStargazers(
            repo: repository,
            owner: owner
        ) { result in
            switch result {
            case .success(let stargasers):
                completion(.success(stargasers))
            case .failure(let networkError):
                completion(.failure(.network(networkError)))
            }
        }
    }
}
