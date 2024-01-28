//
//  FeedViewModel.swift
//  gg
//
//  Created by Rian O'Leary on 07/08/2023.
//

import Foundation
import Firebase


class FeedViewModel: ObservableObject {
    @Published var feed = [Post]()
    @Published var explore = [Post]()
    
    init(){
        Task{try await fetchPosts()}
    }
    
    @MainActor
    func fetchPosts() async throws{
        
        self.feed = try await PostService.fetchFeedPosts()
        feed.sort{ $0.timestamp > $1.timestamp }
        self.explore = try await PostService.fetchExplorePosts()
        explore.sort{ $0.timestamp > $1.timestamp }
    }
}
