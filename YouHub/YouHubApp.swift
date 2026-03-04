//
//  YouHubApp.swift
//  YouHub
//
//  Created by Novak Velimirovic on 2.3.26..
//

import SwiftUI

@main
struct YouHubApp: App {
    @StateObject private var videoStore = VideoStore() // Global video store
    @StateObject private var session = UserSession()   // User session info

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(videoStore)
                .environmentObject(session)
        }
    }
}
