//
//  FriendsListBox.swift
//  gg
//
//  Created by Rian O'Leary on 18/08/2023.
//

import SwiftUI
import Kingfisher

struct FriendsListBox: View {
    
    let friend: Friend
    var body: some View {
        
        HStack{
            
            
            
            if let user = friend.user{
                CircularProfileImageView(user: user)
                    .frame(width: 50, height: 50)
                    .padding(.horizontal)
                
                Text(user.username ?? "")
                    .bold()
                    .font(.title3)
                    .foregroundColor(Color("TextColor"))
            }
            
            
            
            
            
            Spacer()
            
            
            Button{
                
            }label: {
                Image(systemName: "ellipsis")
                    .padding(.horizontal)
                    .foregroundColor(Color("TextColor"))
            }
            
        }
    }
}

struct FriendsListBox_Previews: PreviewProvider {
    static var previews: some View {
        FriendsListBox(friend: Friend.MOCK_FRIENDS[1])
    }
}
