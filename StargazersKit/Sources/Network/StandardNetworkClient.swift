//
//  StandardNetworkClient.swift
//  StargazersKit
//
//  Created by Roberto Casula on 17/03/22.
//

import Foundation

struct StandardNetworkClient: NetworkClientProtocol {

    func dataRequest<R>(
        _ request: R,
        completion: @escaping (Result<R.Response, NetworkError>) -> Void
    ) where R : Request {
        guard let urlComponent = URLComponents(string: request.url),
              let url = urlComponent.url
        else { completion(.failure(.invalidEndpoint)); return }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = request.headers

        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completion(.failure(.unknown(error)))
                return
            }

            guard let response = response as? HTTPURLResponse
            else { completion(.failure(.invalidResponse)); return }

            guard response.statusCode.isValidStatusCode else {
                completion(.failure(.init(statusCode: response.statusCode) ?? .invalidResponse))
                return
            }

            guard let data = data
            else { completion(.failure(.emptyResponse)); return }

            do {
                try completion(.success(request.decode(data)))
            } catch let error {
                completion(.failure(.decoding(error)))
            }
        }
        .resume()
    }
}
