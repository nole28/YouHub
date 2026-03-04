//
//  UserSession.swift
//  YouHub
//
//  Created by Novak Velimirovic on 2.3.26..
//

import Foundation

// MARK: - User Session Manager
/// Observable object storing user information and subscription state.
final class UserSession: ObservableObject {
    /// Current logged-in user
    @Published var user = User(
        id: UUID(),
        username: "Novak",
        avatarURL: nil,
        subscribers: 0,
        subscribedChannelID: []
    )

    // MARK: - Subscription Management
    /// Toggles subscription state for a channel.
    func toggleSubscription(channelID: UUID) {
        if user.subscribedChannelID.contains(channelID) {
            user.subscribedChannelID.remove(channelID)
        } else {
            user.subscribedChannelID.insert(channelID)
        }
    }
}
