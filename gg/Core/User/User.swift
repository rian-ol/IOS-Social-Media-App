//
//  User.swift
//  gg
//
//  Created by Rian O'Leary on 01/08/2023.
//

import Foundation
import Firebase


struct UserModel: Identifiable, Hashable, Codable{
    let id: String
    var username: String?
    var profileImageUrl: String?
    let email: String
    var college: String
    
    var isCurrentUser: Bool{
        guard let currentUid = Auth.auth().currentUser?.uid else {return false}
        return currentUid == id
    }
    var keywordsforlookup: [String] {
        [self.username!.generateStringSequence()].flatMap{ $0 }
    }
    
}


struct Matches: Codable{
    var random: Bool
    var friend: Bool
    var Link: Bool
    var Relationship: Bool
}



struct UserPref: Identifiable, Codable{
    let id: String
    var RandomOpt: Bool
    var FriendOpt: Bool
    var LinkOpt: Bool
    var RelationshipOpt: Bool
    
    init(id: String){
        self.id = id
        RelationshipOpt = false
        FriendOpt = false
        LinkOpt = false
        RandomOpt = false
    }
}






struct UserMatches: Identifiable, Codable{
    let id: String
    var potentialMatch: String
    var matchType: String
    var matched: Bool
    var timeMatched: Timestamp
   
}


extension UserModel{
    
    static var MOCK_USERS: [UserModel] = [
        .init(id: NSUUID().uuidString, username: "frank", profileImageUrl: "image", email: "frank@frank.frank", college:  "University of Limerick"),
        .init(id: NSUUID().uuidString, username: "brad",  email: "brad@brad.brad", college:  "Limerick"),
        .init(id: NSUUID().uuidString, username: "ben", email: "ben@ben.ben", college:  "Limerick"),
        .init(id: NSUUID().uuidString, username: "grat",email: "grat@grat.grat", college:  "Limerick"),
        .init(id: NSUUID().uuidString, username: "steve", email: "steve@steve.steve", college:  "Limerick"),
        .init(id: NSUUID().uuidString, username: "kwon", email: "kwon@kwon.kwon", college:  "Limerick"),
        .init(id: NSUUID().uuidString, username: "bubby",email: "bubby@bubby.bubby", college:  "Limerick"),
        .init(id: NSUUID().uuidString, username: "matt", email: "matt@matt.matt", college:  "Limerick" ),
    ]
    
    
    
    
}

extension String {
    func generateStringSequence() -> [String]{
        
        guard self.count > 0 else {return []}
        var sequences: [String] = []
        for i in 1...self.count{
            
            sequences.append(String(self.prefix(i)))
            print(sequences)
        }
        return sequences
    }
}



extension UserPref{
    
    static var MOCK_DATA: [UserPref] = [
    
        .init(id: NSUUID().uuidString)
    
    ]
}
