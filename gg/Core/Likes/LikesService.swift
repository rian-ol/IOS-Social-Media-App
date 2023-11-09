//
//  LikesService.swift
//  gg
//
//  Created by Rian O'Leary on 20/08/2023.
//

import Foundation
import Firebase


struct LikeService {
    
    func getLikes(withID postID: String) async throws -> String{
        var intReturn = ""
        
        let query = Firestore.firestore().collection("likes").document(postID).collection("likes")
        let countQuery = query.count
        do{
            let snapshot = try await countQuery.getAggregation(source: .server)
            intReturn = snapshot.count.stringValue
        }
    
      
        return intReturn
    }
}
