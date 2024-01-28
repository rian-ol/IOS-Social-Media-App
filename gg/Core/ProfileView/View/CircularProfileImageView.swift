//
//  CircularProfileImageView.swift
//  gg
//
//  Created by Rian O'Leary on 07/08/2023.
//

import SwiftUI
import Kingfisher

struct CircularProfileImageView: View {
    
    let user: UserModel
    
    var body: some View {
        
        VStack{
            
            
            if let imageUrl = user.profileImageUrl {
                if imageUrl != "" {
                    KFImage(URL(string: imageUrl))
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                }else {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .clipShape(Circle())
                }
            }
                
        }
    }
}

struct CircularProfileImageView_Previews: PreviewProvider {
    static var previews: some View {
        CircularProfileImageView(user: UserModel.MOCK_USERS[0])
    }
}
