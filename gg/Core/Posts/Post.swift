//
//  Post.swift
//  gg
//
//  Created by Rian O'Leary on 05/08/2023.
//

import Foundation
import Firebase


struct Post: Identifiable, Hashable, Codable{
    let id: String
    let ownerUid: String
    let caption: String
    var likes: Int
    let imageUrl: String
    let timestamp: Date
    var user: UserModel?
    var friendview: Bool
    var linkview: Bool
    var relview: Bool
    var global: Bool
    
}


extension Post {
    static var MOCK_POSTS: [Post] = [
        .init(id: NSUUID().uuidString, ownerUid: NSUUID().uuidString, caption: "Post", likes: 9, imageUrl: "perfect-square", timestamp: Date(), user: UserModel.MOCK_USERS[0], friendview: true, linkview: true, relview: true, global: true),
        .init(id: NSUUID().uuidString, ownerUid: NSUUID().uuidString, caption: "Post", likes: 9, imageUrl: "perfect-square", timestamp: Date(), user: UserModel.MOCK_USERS[0],friendview: true, linkview: true, relview: true, global: true),
        .init(id: NSUUID().uuidString, ownerUid: NSUUID().uuidString, caption: "Post", likes: 9, imageUrl: "perfect-square", timestamp: Date(), user: UserModel.MOCK_USERS[0],friendview: true, linkview: true, relview: true, global: true),
        .init(id: NSUUID().uuidString, ownerUid: NSUUID().uuidString, caption: "Post", likes: 9, imageUrl: "perfect-square", timestamp: Date(), user: UserModel.MOCK_USERS[0],friendview: true, linkview: true, relview: true, global: true),
        .init(id: NSUUID().uuidString, ownerUid: NSUUID().uuidString, caption: "Post", likes: 9, imageUrl: "perfect-square", timestamp: Date(), user: UserModel.MOCK_USERS[0],friendview: true, linkview: true, relview: true, global: true),
        .init(id: NSUUID().uuidString, ownerUid: NSUUID().uuidString, caption: "Post", likes: 9, imageUrl: "perfect-square", timestamp: Date(), user: UserModel.MOCK_USERS[0],friendview: true, linkview: true, relview: true, global: true),
        .init(id: NSUUID().uuidString, ownerUid: NSUUID().uuidString, caption: "lol", likes: 88, imageUrl: "perfect-square", timestamp: Date(), user: UserModel.MOCK_USERS[1],friendview: true, linkview: true, relview: true, global: true),
        .init(id: NSUUID().uuidString, ownerUid: NSUUID().uuidString, caption: "frsaa", likes: 388, imageUrl: "image", timestamp: Date(), user: UserModel.MOCK_USERS[3],friendview: true, linkview: true, relview: true, global: true),
        .init(id: NSUUID().uuidString, ownerUid: NSUUID().uuidString, caption: "mkay", likes: 3, imageUrl: "perfect-square", timestamp: Date(), user: UserModel.MOCK_USERS[5],friendview: true, linkview: true, relview: true, global: true),
        .init(id: NSUUID().uuidString, ownerUid: NSUUID().uuidString, caption: "Post", likes: 344, imageUrl: "image", timestamp: Date(), user: UserModel.MOCK_USERS[2],friendview: true, linkview: true, relview: true, global: true)
    ]
}
