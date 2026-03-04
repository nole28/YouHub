//
//  SearchViewModel.swift
//  YouHub
//
//  Created by Novak Velimirovic on 2.3.26..
//

import Foundation
import Combine

final class SearchViewModel: ObservableObject {
    @Published var searchText = ""
    @Published private(set) var videos: [Video] = []

    private var allVideos: [Video] = []
    private var cancellables = Set<AnyCancellable>()
    private var channelStore: [UUID: Channel] = [:]
    private var store: VideoStore
    
    init(store: VideoStore, channels: [Channel] = Channel.mockData) {
        self.store = store
        self.channelStore = Dictionary(uniqueKeysWithValues: channels.map { ($0.id, $0) })
        self.allVideos = store.videos
        self.videos = store.videos
        
        store.$videos
            .sink { [weak self] updatedVideos in
                guard let self = self else { return }
                self.allVideos = updatedVideos
                self.filterVideos(query: self.searchText)
            }
            .store(in: &cancellables)
        
        
        bindSearch()
    }

    private func filterVideos(query: String) {
        let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else {
            videos = allVideos
            return
        }

        videos = allVideos.filter { video in
            let matchesTitle = video.title.localizedCaseInsensitiveContains(trimmed)
            let matchesChannel = channelStore[video.channelID]?.name.localizedCaseInsensitiveContains(trimmed) ?? false
            return matchesTitle || matchesChannel
        }
    }

    private func bindSearch() {
        $searchText
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] query in self?.filterVideos(query: query) }
            .store(in: &cancellables)
    }
}
