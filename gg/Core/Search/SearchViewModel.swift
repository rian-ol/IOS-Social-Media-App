//
//  SearchViewModel.swift
//  gg
//
//  Created by Rian O'Leary on 03/08/2023.
//

import Foundation
import Firebase


class SearchViewModel: ObservableObject {
    @Published var users: [UserModel] = []
    @Published var searchedUsers: [UserModel] = []
    private var documents: [Friend] = []
    
    
//    init(){
//        Task{ try await fetchAllUsers() }
//    }
    
    
//    @MainActor
//    func fetchAllUsers() async throws {
//        self.users = try await userService.fetchAllUsers()
//    }
    
    func fetchUsers(from keyword: String){
        Firestore.firestore().collection("users").whereField("keywordsforlookup", arrayContains: keyword).getDocuments { querySnapshot, error in
            guard let documents =  querySnapshot?.documents, error == nil else {return}
            self.users = documents.compactMap{ queryDocumentSnapshot in
                try? queryDocumentSnapshot.data(as: UserModel.self)
            }
        }
    }
    
   
    func fetchSearchedUsers(){
        guard let uid = AuthService.shared.currentUser?.id else {return}
        Firestore.firestore().collection("recentsearch").document(uid).collection("recentsearch").getDocuments { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {return}
            self.documents = documents.compactMap{ queryDocumentSnapshot in
                try? queryDocumentSnapshot.data(as: Friend.self)
            }
            
            
        }
        self.documents.sort{ $0.timestamp > $1.timestamp}
        
        for i in 1...10 {
            let user = documents[i].id
            Task{
                self.searchedUsers[i] = try await userService.fetchUser(withUid: user)
            }
        }
        
                
    }
    
    func addNewSearched(withuid uid: String) async throws{
        guard let userid = AuthService.shared.currentUser?.id else {return}
        let newSearch = Friend(id: uid, timestamp: Date())
        guard let encodedValue = try? Firestore.Encoder().encode(newSearch) else {return}
        try await Firestore.firestore().collection("recentsearch").document(userid).collection("recentsearch").document(uid).setData(encodedValue)
    }
    
    
    
    
}
