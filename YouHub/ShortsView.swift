//
//  ShortsView.swift
//  YouHub
//
//  Created by Novak Velimirovic on 2.3.26..
//

import SwiftUI
import AVKit

struct ShortsView: View {
    @EnvironmentObject var store: VideoStore

    var body: some View {
        GeometryReader { geometry in
            TabView {
                ForEach(store.shorts) { video in
                    ShortsVideoCard(video: video)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .environmentObject(store)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
        .ignoresSafeArea()
        .navigationTitle("Shorts")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// Single short video card
struct ShortsVideoCard: View {
    let video: Video
    @EnvironmentObject var store: VideoStore
    @State private var player: AVPlayer?

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Color.black.ignoresSafeArea()

            if let url = URL(string: video.videoURL) {
                VideoPlayer(player: player)
                    .ignoresSafeArea()
                    .onAppear {
                        if player == nil { player = AVPlayer(url: url) }
                        player?.play()
                    }
                    .onDisappear { player?.pause() }
            } else {
                Text("Invalid video URL")
                    .foregroundColor(.white)
            }

            // Overlay with title and channel info
            VStack(alignment: .leading, spacing: 6) {
                Text(video.title)
                    .font(.headline)
                    .foregroundColor(.white)
                    .lineLimit(2)

                if let channel = store.channel(for: video.channelID) {
                    HStack(spacing: 8) {
                        AsyncImage(url: URL(string: channel.avatarURL ?? "")) { phase in
                            if let image = phase.image {
                                image.resizable().scaledToFill()
                            } else {
                                Circle().fill(Color.gray)
                            }
                        }
                        .frame(width: 30, height: 30)
                        .clipShape(Circle())

                        VStack(alignment: .leading, spacing: 2) {
                            Text(channel.name)
                                .font(.subheadline)
                                .foregroundColor(.white.opacity(0.8))
                            Text(video.formattedViews)
                                .font(.caption)
                                .foregroundColor(.white.opacity(0.6))
                        }
                    }
                }
            }
            .padding()
            .background(
                LinearGradient(
                    colors: [.black.opacity(0.7), .black.opacity(0)],
                    startPoint: .bottom,
                    endPoint: .top
                )
            )
        }
    }
}

#Preview {
    NavigationStack {
        ShortsView()
            .environmentObject(VideoStore())
    }
    .preferredColorScheme(.dark)
}
