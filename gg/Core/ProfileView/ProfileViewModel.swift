//
//  File.swift
//  gg
//
//  Created by Rian O'Leary on 22/08/2023.
//

import Foundation
import Firebase


class ProfileViewModel: ObservableObject{
    
    @Published var user: UserModel
    
    init(user:UserModel){
        self.user = user
        
        fetchUser()
    }
    
    
    func fetchUser(){
        let uid = user.id
        Firestore.firestore().collection("users").whereField("id", isEqualTo: uid).addSnapshotListener{ querySnapshots, error in

            if let querySnapshot = querySnapshots{
                querySnapshot.documentChanges.forEach { diff in
                    if (diff.type == .added){
                        let data = diff.document.data()
                        
                        let profileURL = data["profileImageUrl"] as? String
                        let username = data["username"] as? String
                        
                        self.user = UserModel(id: self.user.id, username: username, profileImageUrl: profileURL, email: self.user.email, college: self.user.college)
                    }
                }
            }


        }
    }
}
