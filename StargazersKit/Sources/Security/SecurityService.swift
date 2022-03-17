//
//  SecurityService.swift
//  StargazersKit
//
//  Created by Roberto Casula on 17/03/22.
//

import UIKit
import Foundation

class SecurityService {

    private static let bundleIdentifierMaxLength = 20

    class func isDeviceSecure() throws -> Bool {
        if isDeviceRunningiOSLessThan13() {
            throw StargazerError.iOSVersionTooOld
        }

        if isRunningInSimulator() {
            throw StargazerError.deciceEmulated
        }

        if isDeviceRooted() {
            throw StargazerError.deviceRooted
        }

        if applicationHasTooLongBundleIdentifier() {
            throw StargazerError.packageNameTooLong
        }

        if VpnChecker.isVpnActive() {
            throw StargazerError.vpnConnectionFound
        }
        return true
    }

    class func isDeviceRunningiOSLessThan13() -> Bool {
        if #available(iOS 13, *) {
            return false
        }
        return true
    }

    class func isRunningInSimulator() -> Bool {
#if targetEnvironment(simulator)
        let isSimulator = true
#else
        let isSimulator = false
#endif
        return isSimulator || ProcessInfo().environment["SIMULATOR_DEVICE_NAME"] != nil
    }

    class func isDeviceRooted() -> Bool {
        if deviceCanOpenSuspiciousUrlSchemes() {
            return true
        }

        if deviceHasSuspiciousFiles() {
            return true
        }

        if canDeviceWriteOutsideSandbox() {
            return true
        }

        return false
    }

    class func applicationHasTooLongBundleIdentifier() -> Bool {
        guard let identifier = Bundle.main.bundleIdentifier
        else { return true }
        return identifier.count > bundleIdentifierMaxLength
    }
}

extension SecurityService {

    class func deviceCanOpenSuspiciousUrlSchemes() -> Bool {
        let urlSchemes = [
            "undecimus://",
            "cydia://",
            "sileo://",
            "zbra://"
        ]

        for url in urlSchemes.compactMap(URL.init(string:)) {
            if UIApplication.shared.canOpenURL(url) {
                return true
            }
        }
        return false
    }

    class func deviceHasSuspiciousFiles() -> Bool {
        let paths = [
            "/Applications/Cydia.app",
            "/bin/bash",
            "/usr/sbin/sshd",
            "/etc/apt",
            "/private/var/lib/apt/",
            "/private/var/lib/cydia",
            "/Library/MobileSubstrate/MobileSubstrate.dylib",
            "/Library/MobileSubstrate/DynamicLibraries/Veency.plist",
            "/Library/MobileSubstrate/DynamicLibraries/LiveClock.plist",
            "/System/Library/LaunchDaemons/com.saurik.Cydia.Startup.plist"
        ]

        for path in paths {
            if FileManager.default.fileExists(atPath: path) {
                return true
            }
        }

        return false
    }

    class func canDeviceWriteOutsideSandbox() -> Bool {
        let paths = [
            "/",
            "/root/",
            "/private/"
        ]
        for path in paths {
            do {
                let filePath = path+UUID().uuidString
                try UUID().uuidString.write(toFile: filePath, atomically: true, encoding: String.Encoding.utf8)
                try FileManager.default.removeItem(atPath: filePath)
                return true
            } catch {}
        }
        return false
    }
}
