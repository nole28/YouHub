//
//  ShortVideo.swift
//  YouHub
//
//  Created by Novak Velimirovic on 2.3.26..
//

import SwiftUI
import Foundation

struct ShortVideo: Identifiable, Codable {
    let id: UUID
    let title: String
    let description: String
    let channelName: String
    let channelAvatar: String?
    let videoURL: String
    let thumbnailURL: String
    let views: Int
    let likes: Int
    let comments: Int
    let timestamp: Date
    let duration: Int
    let category: String
    let isLiked: Bool
    let isSubscribed: Bool
    
    init(id: UUID, title: String, description: String, channelName: String, channelAvatar: String?, videoURL: String, thumbnailURL: String, views: Int = 0, likes: Int, comments: Int, timestamp: Date, duration: Int, category: String, isLiked: Bool, isSubscribed: Bool) {
        self.id = id
        self.title = title
        self.description = description
        self.channelName = channelName
        self.channelAvatar = channelAvatar
        self.videoURL = videoURL
        self.thumbnailURL = thumbnailURL
        self.views = views
        self.likes = likes
        self.comments = comments
        self.timestamp = Date()
        self.duration = duration
        self.category = category
        self.isLiked = isLiked
        self.isSubscribed = isSubscribed
    }
    

    var formattedViews: String {
        if views >= 1000000 {
            return String(format: "%.1fM views", Double(views) / 1000000)
        } else if views >= 1000 {
            return String(format: "%.1fK views", Double(views) / 1000)
        }
        return "\(views) views"
        
    }
    
    var formattedTime: String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .abbreviated
        return formatter.localizedString(for: timestamp, relativeTo: Date())
    }
    
    var formattedDuration: String {
        let minutes = duration / 60
        let seconds = duration % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
}
