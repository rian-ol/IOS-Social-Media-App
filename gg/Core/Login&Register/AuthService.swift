//
//  AuthService.swift
//  gg
//
//  Created by Rian O'Leary on 27/07/2023.
//

import Foundation
import FirebaseAuth
import FirebaseFirestoreSwift
import Firebase


class AuthService {
    
    
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: UserModel?
    @Published var verifiedEmail: Bool?
    @Published var user = Auth.auth().currentUser
    
    
    static let shared = AuthService()
    
    init(){
        Task{try await loadUserData()}
    }
    
    
    @MainActor
    func login (withEmail email: String, password: String) async throws{
        do{
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            
            self.userSession = result.user
            try await loadUserData()
        }catch{
            print("Debug login \(error.localizedDescription)")
        }
    }
    
    
    @MainActor
    func createUser (email: String, password: String, college: String) async throws{
        do{
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            
            self.userSession = result.user
            
            await self.uploadUserData(uid: result.user.uid, email: email, college: college)
            
            await emailVerification()
            
        }catch{
            print("Debug register \(error.localizedDescription)")
        }
    }
    
    
    @MainActor
    func loadUserData() async throws{
        self.userSession = Auth.auth().currentUser
        guard let currentUid = userSession?.uid else {return}
        
        self.verifiedEmail = false
        self.currentUser = try await userService.fetchUser(withUid: currentUid)
    }
    
    
    func signOut(){
        try? Auth.auth().signOut()
        self.userSession = nil
        self.currentUser = nil
    }
    
    @MainActor
    func deleteAccount() async throws{
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let friend = Friend(id: uid, timestamp: Date())
        guard let encodedFriend = try? Firestore.Encoder().encode(friend) else {return}
        try? await Firestore.firestore().collection("deletedUsers").document(uid).setData(encodedFriend)
        
        signOut()
    }
    
    

    @MainActor
    private func uploadUserData(uid: String, email: String, college: String) async{
        
        let user = UserModel(id: uid, username:"", profileImageUrl: "", email: email, college: college)
        self.currentUser = user
        guard let encodedUser = try? Firestore.Encoder().encode(user) else {return}
        
        try? await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
        try? await Firestore.firestore().collection("users").document(user.id).updateData(["keywordsforlookup": user.keywordsforlookup])
        
        let userPref = UserPref(id: user.id)
        guard let encodedPref = try? Firestore.Encoder().encode(userPref) else {return}
        try? await Firestore.firestore().collection("userPref").document(user.id).setData(encodedPref)
        try? await Firestore.firestore().collection("friends").document(uid).setData(["id" : uid])
        try? await Firestore.firestore().collection("messages").document(uid).setData(["id" : uid])
        try? await Firestore.firestore().collection("likes").document(uid).setData(["id" : uid])
        try? await Firestore.firestore().collection("recentsearch").document(uid).setData(["id" : uid])
    }
    
    
    
    func emailVerification() async{
        
        {Auth.auth().currentUser?.sendEmailVerification{
            error in
        }}()
    }

    
}
