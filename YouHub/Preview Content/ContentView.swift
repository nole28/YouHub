//
//  ContentView.swift
//  YouHub
//
//  Created by Novak Velimirovic on 2.3.26..
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var session: UserSession
    @StateObject private var videoStore: VideoStore
    @StateObject private var searchViewModel: SearchViewModel

    init() {
        let store = VideoStore()
        _videoStore = StateObject(wrappedValue: store)
        _searchViewModel = StateObject(wrappedValue: SearchViewModel(store: store))
        
    
    }
    
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            // Home Tab
            NavigationStack {
                HomeView(viewModel: searchViewModel)
            }
            .tabItem {
                Label("Home", systemImage: selectedTab == 0 ? "house.fill" : "house")
            }
            .tag(0)
            
            // Shorts Tab
            NavigationStack {
                ShortsView()
            }
            .tabItem {
                Label("Shorts", systemImage: selectedTab == 1 ? "play.square.stack.fill" : "play.square.stack")
            }
            .tag(1)
            
            // Upload Tab
            NavigationStack {
                UploadView()
            }
            .tabItem {
                Label("Upload", systemImage: "plus.circle")
            }
            .tag(2)
            
            // Subscriptions Tab
            NavigationStack {
                SubscriptionsView()
            }
            .tabItem {
                Label("Subscriptions", systemImage: "rectangle.stack.person.crop")
            }
            .tag(3)
            
            // Profile Tab
            NavigationStack {
                ProfileView()
            }
            .tabItem {
                Label("Profile", systemImage: "person.circle")
            }
            .tag(4)
        }
        .environmentObject(videoStore)
    }
}

#Preview {
    ContentView()
        .environmentObject(VideoStore())
        .environmentObject(UserSession())
}

