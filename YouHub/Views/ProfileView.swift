//
//  ProfileView.swift
//  YouHub
//
//  Created by Novak Velimirovic on 2.3.26..
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var session: UserSession
    @EnvironmentObject var store: VideoStore

    var userVideos: [Video] {
        store.videos.filter { $0.channelID == session.user.id }
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Avatar
                if let avatar = session.user.avatarURL,
                   let url = URL(string: avatar) {
                    AsyncImage(url: url) { image in
                        switch image {
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                        default:
                            Circle().fill(Color.gray)
                            
                        }
                    }
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                } else {
                    Circle()
                        .fill(Color.gray.opacity(0.4))
                        .frame(width: 80, height: 80)
                        .overlay(
                            Image(systemName: "person.fill")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                )
            }

                Text(session.user.username)
                    .font(.title2)
                    .bold()

                Text("\(session.user.subscribers) subscribers")
                    .foregroundStyle(.secondary)

                Divider()

                VStack(alignment: .leading, spacing: 12) {
                    Text("My clips")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    if userVideos.isEmpty {
                        VStack(spacing: 12) {
                            Image(systemName: "video.slash")
                                .font(.largeTitle)
                                .foregroundStyle(.secondary)
                            Text("no videos yet :/")
                                .foregroundStyle(.secondary)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.top, 20)
                    } else {
                        LazyVStack(spacing: 12) {
                            ForEach(userVideos) { video in
                                NavigationLink {
                                    VideoDetail(video: video)
                                } label: {
                                    VideoThumbnail(video: video)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Account")
    }
}


#Preview {
    ProfileView()
        .environmentObject(UserSession())
        .environmentObject(VideoStore())
}
