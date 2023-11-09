//
//  PostGridVM.swift
//  gg
//
//  Created by Rian O'Leary on 10/08/2023.
//

import Foundation
import Firebase
import SwiftUI


class PostGridVM: ObservableObject{
    
    private let user: UserModel
    @Published var posts: [Post] = []
    
    
    init(user: UserModel){
        self.user = user
        fetchUserPosts(uid: user.id)
//        Task{try await fetchUserPosts()}
    }
    
//    @MainActor
//    func fetchUserPosts() async throws{
//        self.posts = try await PostService.fetchUserPosts(uid: user.id)
//
//        for i in 0 ..< posts.count{
//            posts[i].user = self.user
//        }
//
//    }
    
    
     func fetchUserPosts(uid: String) {
        
        Firestore.firestore().collection("posts").whereField("ownerUid", isEqualTo: uid).addSnapshotListener{ querySnapshot, error in
            guard let documents = querySnapshot?.documents else{
              
                
                return
            }
//            self.posts = documents.map{ (QueryDocumentSnapshot) -> Post in
//                    let data = QueryDocumentSnapshot.data()
//
//                   let id = data["id"] as? String ?? ""
//                   let caption = data["caption"] as? String ?? ""
//                   let likes = data["likes"] as? Int ?? 0
//                   let imageUrl = data["imageUrl"] as? String ?? ""
//                   let timestamp = data["timestamp"]as? Date
//
//                   return Post(id: id, ownerUid: uid, caption: caption, likes: likes, imageUrl: imageUrl, timestamp: timestamp)
            
            self.posts = documents.compactMap { document -> Post? in
                do {
                    return try document.data(as: Post.self)
                }catch{
                    return nil
                }
            }
            
            self.posts.sort{ $0.timestamp > $1.timestamp }
           
        }
         
       }
    
   
    
}
