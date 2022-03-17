//
//  DataRequest.swift
//  
//
//  Created by Roberto Casula on 17/03/22.
//

import Foundation

enum Method: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

protocol Request {
    associatedtype Response

    var url: String { get }

    var method: Method { get }
    var headers: [String : String] { get }

    var decoder: JSONDecoder { get }

    func decode(_ data: Data) throws -> Response
}

extension Request {

    static func getUrl(for baseUrl: String, path: String, pathParameters: [String: String]) -> String {
        var path = path
        pathParameters.forEach { key, value in
            path = path.replacingOccurrences(of: "{\(key)}", with: value)
        }
        return baseUrl + path
    }
}
