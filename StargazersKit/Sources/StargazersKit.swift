//
//  StargazersKit.swift
//  
//
//  Created by Roberto Casula on 16/03/22.
//

import Foundation

public class StargazersKit {

    /// The StargazersKit shared instance. Throws a `fatalError` if `StargazersKit.configure()` is not called before using it.
    public static var shared: StargazersKit {
        guard isSetupDone, let sharedInstance = _shared else {
            fatalError("[StargazersKit] ERROR: You must call `StargazersKit.configure()`")
        }
        return sharedInstance
    }

    private static var _shared: StargazersKit?
    private static var isSetupDone: Bool = false

    private var stargazersService: StargazersService

    private init(stargazersService: StargazersService) {
        self.stargazersService = stargazersService
    }

    /// Configures a default StargazersKit instance. Raises an exception if any configuration step fails.
    /// This method should be called after the app is launched and before using the StargazersKit shared instance.
    public class func configure() {
        configure(networkClient: StandardNetworkClient())
    }

    /// Internal configuration method.
    /// - Parameter networkClient: The network client. Useful for mocking purposes.
    class func configure(networkClient: NetworkClientProtocol) {
        guard !isSetupDone else { return }
        _shared = .init(
            stargazersService: .init(networkClient: networkClient)
        )
        isSetupDone = true
    }

    /// This method returns the list of `Stargazer` of the given repository if the security standards are met.
    /// - Parameters:
    ///   - repository: The repository name
    ///   - owner: The repository owner
    ///   - completion: Completion block that returns a `Result<[Stargazer], StargazerError>)`
    public func stargazers(
        for repository: String,
        owner: String,
        completion: @escaping (Result<[Stargazer], StargazerError>) -> Void
    ) {
        do {
            guard try SecurityService.isDeviceSecure()
            else { completion(.failure(.deviceUnsecure)); return }

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
        } catch let error as StargazerError {
            completion(.failure(error))
        } catch let error {
            completion(.failure(.unknown(error)))
        }
    }
}
