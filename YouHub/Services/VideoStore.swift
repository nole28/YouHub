//
//  VideoStore.swift
//  YouHub
//
//  Created by Novak Velimirovic on 2.3.26..
//

import Foundation

final class VideoStore: ObservableObject {
    @Published var videos: [Video] = Video.mockData
    @Published var channels: [Channel] = Channel.mockData
    @Published var shorts: [Video] = []

    init() {
        updateShorts()
    }

    // MARK: - Methods
    func addVideo(_ video: Video) {
        videos.insert(video, at: 0)
        updateShorts()
    }

    func channel(for id: UUID) -> Channel? {
        channels.first { $0.id == id }
    }

    private func updateShorts() {
        shorts = videos.filter { $0.duration <= 60 }
    }
    
    var homeFeed: [Video] {
        videos.sorted { $0.uploadDate > $1.uploadDate }
    }
    
    func videos(for channelID: UUID) -> [Video] {
        videos.filter { $0.channelID == channelID }
    }
}
