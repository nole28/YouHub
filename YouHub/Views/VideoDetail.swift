//
//  VideoDetail.swift
//  YouHub
//
//  Created by Novak Velimirovic on 2.3.26..
//

import SwiftUI

struct VideoDetail: View {
    let video: Video
    @EnvironmentObject var session: UserSession
    @EnvironmentObject var store: VideoStore

    var body: some View {
        VStack(spacing: 12) {
            if let url = URL(string: video.videoURL) {
                VideoPlayerView(url: url)
                    .frame(height: 260)
                    .padding(.horizontal)
            } else {
                ContentUnavailableView("Invalid video URL", systemImage: "exclamationmark.triangle")
                    .frame(height: 260)
                    .padding(.horizontal)
            }

            Text(video.title)
                .font(.title2)
                .bold()
                .padding(.horizontal)

            
            
            HStack {
                Circle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 40, height: 40)
                
                VStack(alignment: .leading, spacing: 2) {
                    if let channel = store.channel(for: video.channelID) {
                        Text(channel.name)
                            .font(.subheadline)
                            .bold()
                        Text("\(channel.subscribersCount / 1000)K subscribers!")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
                
                
                Spacer()
                
                Button(action: {
                    session.toggleSubscription(channelID: video.channelID)
                }) {
                    Text(session.user.subscribedChannelID.contains(video.channelID) ? "Unfollow" : "Follow")
                        .font(.subheadline)
                        .bold()
                        .padding(.horizontal, 15)
                        .padding(.vertical, 7)
                        .background(session.user.subscribedChannelID.contains(video.channelID) ? Color.gray.opacity(0.4) : Color.red)
                        .foregroundColor(session.user.subscribedChannelID.contains(video.channelID) ? .primary : .white)
                        .clipShape(Capsule())
                    
                }
            }
            .padding(.horizontal)
        
            Text(video.description)
                .padding(.horizontal)

            Spacer()
        }
        .navigationTitle("Video")
        .navigationBarTitleDisplayMode(.inline)
    }
}
