//
//  Message.swift
//  gg
//
//  Created by Rian O'Leary on 19/08/2023.
//

import Foundation


struct Message: Identifiable, Codable {
    var id: String
    var text: String
    var received: Bool
    var timestamp: Date
    var userID: String
}



extension Message{
    static var MOCK_MESSAGES: [Message] = [
        .init(id: "134", text: "Test", received: true, timestamp: Date(), userID: UUID().uuidString),
        .init(id: "144", text: "This is not a test", received: false, timestamp: Date(), userID: UUID().uuidString),
        .init(id: "134", text: "Test", received: true, timestamp: Date(), userID: UUID().uuidString)
    ]
}
