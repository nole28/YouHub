//
//  User.swift
//  YouHub
//
//  Created by Novak Velimirovic on 2.3.26..
//

import Foundation

struct User: Identifiable, Codable {
    let id: UUID
    var username: String
    var avatarURL: String?
    var subscribers: Int
    var subscribedChannelID: Set<UUID>
}
