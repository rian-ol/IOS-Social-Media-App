//
//  IndividualPostView.swift
//  gg
//
//  Created by Rian O'Leary on 20/08/2023.
//

import SwiftUI

struct IndividualPostView: View {
    
    let post: Post
    let edit: Bool
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack{
            
            FeedCell(post: post, edit: edit)
        }
    }
}

struct IndividualPostView_Previews: PreviewProvider {
    static var previews: some View {
        IndividualPostView(post: Post.MOCK_POSTS[0], edit: true)
    }
}
