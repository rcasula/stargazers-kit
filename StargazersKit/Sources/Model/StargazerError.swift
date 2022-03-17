//
//  StargazerError.swift
//  
//
//  Created by Roberto Casula on 17/03/22.
//

import Foundation

public enum StargazerError: Error {

    case deviceRooted
    case deciceEmulated
    case vpnConnectionFound
    case packageNameTooLong
    case iOSVersionTooOld

    case network(NetworkError)
}
