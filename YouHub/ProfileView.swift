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
                        image.resizable().scaledToFill()
                    } placeholder: {
                        Circle().fill(Color.gray)
                    }
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                } else {
                    Circle()
                        .fill(Color.gray)
                        .frame(width: 80, height: 80)
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

                    LazyVStack(alignment: .leading, spacing: 12) {
                        if userVideos.isEmpty {
                            Text("You haven't uploaded any videos yet.")
                                .foregroundStyle(.secondary)
                                .padding(.top, 20)
                        } else {
                            ForEach(userVideos) { video in
                                NavigationLink {
                                    VideoDetail(video: video)
                                } label: {
                                    VideoThumbnail(video: video)
                                        .environmentObject(store)
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
}
