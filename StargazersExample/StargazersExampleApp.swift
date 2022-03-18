//
//  StargazersExampleApp.swift
//  StargazersExample
//
//  Created by Roberto Casula on 16/03/22.
//

import StargazersKit
import SwiftUI

@main
struct StargazersExampleApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }

    init() {
        StargazersApp.configure(bundleIdentifier: Bundle.main.bundleIdentifier!)
    }
}
