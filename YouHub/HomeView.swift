//
//  HomeView.swift
//  YouHub
//
//  Created by Novak Velimirovic on 2.3.26..
//



import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: SearchViewModel

    var body: some View {
        VStack(spacing: 0) {
            SearchBar(searchText: $viewModel.searchText) { }

            if viewModel.videos.isEmpty {
                Spacer()
                Text("No videos available")
                    .foregroundStyle(.secondary)
                Spacer()
            } else {
                ScrollView {
                    LazyVStack(spacing: 20) {
                        ForEach(viewModel.videos) { video in
                            NavigationLink(destination: VideoDetail(video: video)) {
                                VideoThumbnail(video: video)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.vertical)
                }
            }
        }
        .navigationTitle("Home")
    }
}
