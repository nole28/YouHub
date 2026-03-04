//
//  Channel.swift
//  YouHub
//
//  Created by Novak Velimirovic on 2.3.26..
//

import Foundation

struct Channel: Identifiable, Codable {
    let id: UUID
    var name: String
    var avatarURL: String?
    let subscribersCount: Int
}

// MARK: - Mock Data
extension Channel {
    static let mockData: [Channel] = [
        Channel(id: Video.failArmyChannelID, name: "FailArmy", avatarURL: nil, subscribersCount: 12_500_000),
        Channel(id: Video.iosAcademyChannelID, name: "iOS Academy", avatarURL: nil, subscribersCount: 1_200_000)
    ]
}
