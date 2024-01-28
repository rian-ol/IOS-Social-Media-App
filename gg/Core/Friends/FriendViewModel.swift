//
//  FriendViewModel.swift
//  gg
//
//  Created by Rian O'Leary on 19/08/2023.
//

import Foundation
import Firebase

class FriendViewModel: ObservableObject {
    
    @Published var friends = [Friend]()
    @Published var relationships = [Friend]()
    @Published var links = [Friend]()
    @Published var user: UserModel
    @Published var picker = "Friend"
   
    
    init(user: UserModel){
        self.user = user
        Task{try await getFriends()}
    }
    
    @MainActor
    func getFriends() async throws{
        
        self.friends = try await FriendsService.getUserFriends(withUid: user.id, colName: "friends")
        self.relationships = try await FriendsService.getUserFriends(withUid: user.id, colName: "relationships")
        self.links = try await FriendsService.getUserFriends(withUid: user.id, colName: "links")
    }
    
    func setPicker(type: String){
        self.picker = type
    }
    
     
    
}
