//
//  Friend.swift
//  gg
//
//  Created by Rian O'Leary on 19/08/2023.
//

import Foundation

struct Friend: Identifiable, Hashable, Codable{
    let id: String
    var user: UserModel?
    let timestamp: Date
}

struct potFriend: Identifiable, Hashable, Codable{
    let id: String
    let timestamp: Date
    let sentOrReceived: Bool
}




extension Friend{
    static var MOCK_FRIENDS: [Friend] = [
        .init(id: NSUUID().uuidString, user: UserModel.MOCK_USERS[0], timestamp: Date()),
        .init(id: NSUUID().uuidString, user: UserModel.MOCK_USERS[2], timestamp: Date()),
        .init(id: NSUUID().uuidString, user: UserModel.MOCK_USERS[4], timestamp: Date()),
        .init(id: NSUUID().uuidString, user: UserModel.MOCK_USERS[1], timestamp: Date())
    ]
}
