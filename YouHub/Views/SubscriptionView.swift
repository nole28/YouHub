//
//  SubscriptionView.swift
//  YouHub
//
//  Created by Novak Velimirovic on 2.3.26..
//

import SwiftUI

struct SubscriptionsView: View {
    @EnvironmentObject var store: VideoStore
    @EnvironmentObject var session: UserSession


    // MARK: - Computed Properties
    /// Returns all videos from channels the current user is subscribed to.
    var subscribedVideos: [Video] {
        store.videos.filter { session.user.subscribedChannelID.contains($0.channelID) }
    }

    var body: some View {
        ScrollView {
            if subscribedVideos.isEmpty {
                // Placeholder for no subscriptions
                VStack(spacing: 12) {
                    Image(systemName: "bell.slash")
                        .font(.largeTitle)
                        .foregroundStyle(.secondary)
                    Text("No subscriptions yet")
                        .foregroundStyle(.secondary)
                }
                .padding(.top, 100)
            } else {
                LazyVStack(spacing: 20) {
                    ForEach(subscribedVideos) { video in
                        NavigationLink {
                            VideoDetail(video: video)
                        } label: {
                            VStack(alignment: .leading, spacing: 5) {
                                VideoThumbnail(video: video)

                            }
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.vertical)
            }
        }
        .navigationTitle("Follows")
    }
}

#Preview {
    SubscriptionsView()
        .environmentObject(VideoStore())
        .environmentObject(UserSession())
}

