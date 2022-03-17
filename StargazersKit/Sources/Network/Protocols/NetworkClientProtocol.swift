//
//  NetworkClient.swift
//  
//
//  Created by Roberto Casula on 16/03/22.
//

import Foundation

protocol NetworkClientProtocol {

    func dataRequest<R: Request>(_ request: R, completion: @escaping (Result<R.Response, NetworkError>) -> Void)
}
