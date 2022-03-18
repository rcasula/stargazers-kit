//
//  StargazersKit.swift
//
//
//  Created by Roberto Casula on 16/03/22.
//

import Foundation

public class StargazersApp {

    /// The StargazersKit shared instance. Throws a `fatalError` if `StargazersKit.configure()` is not called before using it.
    public static var shared: StargazersApp {
        guard isSetupDone, let sharedInstance = _shared else {
            fatalError("[StargazersKit] ERROR: You must call `StargazersKit.configure()`")
        }
        return sharedInstance
    }

    private static var _shared: StargazersApp?
    private static var isSetupDone: Bool = false

    private var stargazersService: StargazersService
    private var hostBundleIdentifier: String

    private init(bundleIdentifier: String, stargazersService: StargazersService) {
        self.hostBundleIdentifier = bundleIdentifier
        self.stargazersService = stargazersService
    }

    /// Configures a default StargazersApp instance. Raises an exception if any configuration step fails.
    /// This method should be called after the app is launched and before using the StargazersApp shared instance.
    /// - Parameter bundleIdentifier: The bundle identifier of the Host application.
    public class func configure(bundleIdentifier: String = Bundle.main.bundleIdentifier!) {
        configure(bundleIdentifier: bundleIdentifier, networkClient: StandardNetworkClient())
    }

    /// Internal configuration method.
    /// - Parameter bundleIdentifier: The bundle identifier of the Host application.
    /// - Parameter networkClient: The network client. Useful for mocking purposes.
    class func configure(bundleIdentifier: String, networkClient: NetworkClientProtocol) {
        guard !isSetupDone else { return }
        _shared = .init(
            bundleIdentifier: bundleIdentifier,
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
            guard try SecurityService.isDeviceSecure(bundleIdentifier: hostBundleIdentifier)
            else {
                completion(.failure(.deviceUnsecure))
                return
            }

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
