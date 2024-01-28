//
//  PostService.swift
//  gg
//
//  Created by Rian O'Leary on 10/08/2023.
//

import Foundation
import Firebase


struct PostService{
    
    
    static func fetchFeedPosts() async throws -> [Post]{
        
        let snapshot = try await Firestore.firestore().collection("posts").getDocuments()
        var posts = try snapshot.documents.compactMap({try $0.data(as: Post.self)})
        var feed = [Post]()
        guard let currentUser = Auth.auth().currentUser else {return feed}
        for i in 0 ..< posts.count {
            let post = posts[i]
            let ownerUid = post.ownerUid
            let postUser = try await userService.fetchUser(withUid: ownerUid)
            posts[i].user = postUser
            
            if currentUser.uid == ownerUid{
                feed.append(posts[i])
            }
            
            if posts[i].friendview {
                if try await FriendsService.hasMatch(withUid: ownerUid){
                    feed.append(posts[i])
                }
            }else if posts[i].linkview{
                if try await FriendsService.hasLinkMatch(withUid: ownerUid){
                    feed.append(posts[i])
                }
            }else if posts[i].relview{
                if try await FriendsService.hasRelMatch(withUid: ownerUid){
                    feed.append(posts[i])
                }
            }
            
        }
        posts.sort{ $0.timestamp < $1.timestamp }
        
        
        return feed
    }
    
    
    
    static func fetchExplorePosts() async throws -> [Post]{
        let snapshot = try await Firestore.firestore().collection("posts").getDocuments()
        var feed = [Post]()
        var posts = try snapshot.documents.compactMap({try $0.data(as: Post.self)})
        
        for i in 0 ..< posts.count {
            let post = posts[i]
            let ownerUid = post.ownerUid
            let postUser = try await userService.fetchUser(withUid: ownerUid)
            posts[i].user = postUser
            
            
            if posts[i].global {
                feed.append(posts[i])
            }
            
        }
                
        
        feed.sort{ $0.timestamp > $1.timestamp }
        
        return feed
    }
    
    static func fetchUserPosts(uid: String) async throws -> [Post]{
        
        let snapshot = try await Firestore.firestore().collection("posts").whereField("ownerUid", isEqualTo: uid).getDocuments()
                
        return try snapshot.documents.compactMap({try $0.data(as: Post.self)})
    }
    
}
