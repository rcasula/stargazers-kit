//
//  NetworkError.swift
//  
//
//  Created by Roberto Casula on 17/03/22.
//

import Foundation

public enum NetworkError: Error {

    case notFound
    case badRequest

    case invalidEndpoint
    case invalidResponse
    case emptyResponse
    
    case decoding(Error)
    case unknown(Error)

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
