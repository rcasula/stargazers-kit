//
//  NetworkError.swift
//  
//
//  Created by Roberto Casula on 17/03/22.
//

import Foundation

public enum NetworkError: LocalizedError {

    case notFound
    case badRequest

    case invalidEndpoint
    case invalidResponse
    case emptyResponse
    
    case decoding(Error)
    case unknown(Error)

    public var errorDescription: String? {
        switch self {
        case .notFound:
            return "The repository you are looking for does not exists."
        case .badRequest:
            return "Bad request"
        case .invalidEndpoint:
            return "The endpoint you provided is invalid."
        case .invalidResponse:
            return "The response is invalid."
        case .emptyResponse:
            return "The response is empty."
        case .decoding(let error),
             .unknown(let error):
            return error.localizedDescription
        }
    }

    init?(statusCode: Int) {
        switch statusCode {
        case 400:
            self = .badRequest
        case 404:
            self = .notFound
        default:
            return nil
        }
    }
}
