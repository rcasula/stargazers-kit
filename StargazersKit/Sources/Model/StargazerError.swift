//
//  StargazerError.swift
//  
//
//  Created by Roberto Casula on 17/03/22.
//

import Foundation

public enum StargazerError: LocalizedError {

    case deviceRooted
    case deciceEmulated
    case vpnConnectionFound
    case packageNameTooLong
    case iOSVersionTooOld
    case deviceUnsecure

    case network(NetworkError)
    case unknown(Error)

    public var errorDescription: String? {
        switch self {
        case .deviceRooted:
            return "The device is rooted."
        case .deciceEmulated:
            return "The device is emulated."
        case .vpnConnectionFound:
            return "You are tying to connect under a VPN."
        case .packageNameTooLong:
            return "The bundle identifier is too long."
        case .iOSVersionTooOld:
            return "You are running on an unsecure version of iOS. Try to run on iOS >= 14."
        case .deviceUnsecure:
            return "The device is unsecure."
        case .network(let error):
            return error.errorDescription
        case .unknown(let error):
            return error.localizedDescription
        }
    }
}
