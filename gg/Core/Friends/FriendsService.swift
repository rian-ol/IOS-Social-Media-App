//
//  FriendsService.swift
//  gg
//
//  Created by Rian O'Leary on 18/08/2023.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct FriendsService{
    
    
    static func getUserFriends(withUid uid: String, colName: String) async throws -> [Friend]{
        let snapshot = try await Firestore.firestore().collection("friends").document(uid).collection("\(colName)").getDocuments()
        
        var friends = try snapshot.documents.compactMap({try $0.data(as: Friend.self)})
        
        
        for i in 0..<friends.count{
            let friend = friends[i]
            let friendUID = friend.id
            let toFriend = try await userService.fetchUser(withUid: friendUID)
            friends[i].user = toFriend
        }
        
        return friends
    }
    
    static func hasMatch(withUid uid: String) async throws -> Bool{
       guard let currentUser = Auth.auth().currentUser else {return false}
        
        guard let friendSnap = try? await Firestore.firestore().collection("friends").document(currentUser.uid).collection("friends").document(uid).getDocument() else {return false}
        
        if friendSnap.exists{
            return true
        }
        
        return false
    }
    
    
    
    static func hasLinkMatch(withUid uid: String) async throws -> Bool{
       guard let currentUser = Auth.auth().currentUser else {return false}
        
        guard let linkSnap = try? await Firestore.firestore().collection("friends").document(currentUser.uid).collection("links").document(uid).getDocument() else {return false}
        
        if linkSnap.exists {
            return true
        }
        
        return false
    }
    
    
    
    
    static func hasRelMatch(withUid uid: String) async throws -> Bool{
       guard let currentUser = Auth.auth().currentUser else {return false}
        
        guard let relSnap = try? await Firestore.firestore().collection("friends").document(currentUser.uid).collection("relationships").document(uid).getDocument() else {return false}
        
        if relSnap.exists{
            return true
        }
        
        return false
    }
   
}
