//
//  Video.swift
//  YouHub
//
//  Created by Novak Velimirovic on 2.3.26..
//

import Foundation

struct Video: Identifiable, Codable {
    // MARK: - Properties
    let id: UUID
    let channelID: UUID
    let title: String
    let thumbnailURL: String
    let videoURL: String
    let description: String
    let viewCount: Int
    let uploadDate: Date
    let duration: Int
    
    init(
        id: UUID = UUID(),
        channelID: UUID,
        title: String,
        thumbnailURL: String,
        videoURL: String,
        description: String,
        viewCount: Int = 0,
        uploadDate: Date = Date(),
        duration: Int
    ) {
        self.id = id
        self.channelID = channelID
        self.title = title
        self.thumbnailURL = thumbnailURL
        self.videoURL = videoURL
        self.description = description
        self.viewCount = viewCount
        self.uploadDate = uploadDate
        self.duration = duration
    }
    
    
    // MARK: - Computed Properties
    var metadataText: String {
        uploadDate.formatted(.relative(presentation: .named))
//        "\(formattedViews) • \(uploadDateText)"
    }
    
    // MARK: - Formatting Helpers
    /// Formats view count for display (e.g., 1.5M views, 250K views)
    var formattedViews: String {
        if viewCount >= 1_000_000 {
            return String(format: "%.1fM views", Double(viewCount) / 1_000_000)
        } else if viewCount >= 1_000 {
            return String(format: "%.1fK views", Double(viewCount) / 1_000)
        } else {
            return "\(viewCount) views"
        }
    }
    
    /// Formats duration as MM:SS (e.g., 15:42)
    var formattedDuration: String {
        let minutes = duration / 60
        let seconds = duration % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
    
    
    /// Human-readable relative upload date (e.g., "2 days ago")
    var uploadDateText: String {
        uploadDate.formatted(.relative(presentation: .named))
    }
    

//    /// Alternative relative date format
//    var formattedUploadDate: String {
//        let formatter = RelativeDateTimeFormatter()
//        formatter.unitsStyle = .abbreviated
//        return formatter.localizedString(for: uploadDate, relativeTo: Date())
//    }
    
  
}

// MARK: - Mock Data
extension Video {
    
    static let failArmyChannelID = UUID()
    static let iosAcademyChannelID = UUID()
    static let balkanKitchenChannelID = UUID()
    static let tuningMastersChannelID = UUID()
    static let fitnessProChannelID = UUID()
    
    static let mockData: [Video] = [
        Video(
            channelID: failArmyChannelID,
            title: "Most EPIC Fail Compilation of 2024",
            thumbnailURL: "https://i.ytimg.com/vi/abc123fail/maxresdefault.jpg",
            videoURL: "https://www.youtube.com/watch?v=dQw4w9WgXcQ",
            description: "The funniest fails of the year. Watch people wipe out, crash, and faceplant in this hilarious compilation.",
            viewCount: 4_521_890,
            uploadDate: Calendar.current.date(byAdding: .day, value: -5, to: Date())!,
            duration: /*18 * 60 + 34*/ 30
        ),
        Video(
            channelID: iosAcademyChannelID,
            title: "Learn SwiftUI in 1 Hour",
            thumbnailURL: "https://i.ytimg.com/vi/swiftui/maxresdefault.jpg",
            videoURL: "https://www.youtube.com/watch?v=F2ojC6TNwws",
            description: "Complete SwiftUI tutorial for beginners. Build your first iOS app with this step-by-step guide.",
            viewCount: 1_250_000,
            uploadDate: Calendar.current.date(byAdding: .day, value: -2, to: Date())!,
            duration: 65 * 60 + 12
        ),
        Video(
            channelID: balkanKitchenChannelID,
            title: "Serbian Traditional Cooking - Ćevapi Recipe",
            thumbnailURL: "https://i.ytimg.com/vi/serbiafood/maxresdefault.jpg",
            videoURL: "https://www.youtube.com/watch?v=serbiafood",
            description: "Authentic Serbian ćevapi recipe passed down through generations. Learn the secret spices!",
            viewCount: 850_340,
            uploadDate: Calendar.current.date(byAdding: .day, value: -7, to: Date())!,
            duration: 25 * 60 + 45
        )
        
    ]
}
