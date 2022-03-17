//
//  StargazersExampleApp.swift
//  StargazersExample
//
//  Created by Roberto Casula on 16/03/22.
//

import SwiftUI
import StargazersKit

@main
struct StargazersExampleApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }

    init() {
        StargazersKit.configure(bundleIdentifier: Bundle.main.bundleIdentifier!)
    }
}
