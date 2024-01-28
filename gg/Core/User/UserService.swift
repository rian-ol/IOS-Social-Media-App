//
//  UserService.swift
//  gg
//
//  Created by Rian O'Leary on 03/08/2023.
//

import Foundation
import Firebase
import Combine



struct userService {
    
   static func fetchAllUsers() async throws -> [UserModel]{
       
       let snapshot = try await Firestore.firestore().collection("users").getDocuments()
       
       return snapshot.documents.compactMap({try? $0.data(as: UserModel.self)})
    }
    
    
    static func fetchUser(withUid uid: String) async throws -> UserModel{
        
        let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
        return try snapshot.data(as: UserModel.self)
    }
    
    
    
}





