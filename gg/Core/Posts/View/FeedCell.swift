//
//  FeedCell.swift
//  gg
//
//  Created by Rian O'Leary on 25/07/2023.
//

import SwiftUI
import Kingfisher

struct FeedCell: View {
    
    let post: Post
    let edit: Bool
    @State private var show = false
    @State private var settingsDetent = PresentationDetent.medium
    var body: some View {
        
        VStack {
            UserBar
            
            KFImage(URL(string: post.imageUrl))
                .resizable()
                .scaledToFill()
                .frame(height: 400)
                .contentShape(Rectangle())
                .clipped()
            
            HStack{
                Button {
                    
                }label: {
                    Image(systemName: "heart")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 25, height: 25)
                        .padding(.leading)
                }.foregroundColor(Color("TextColor"))
                
                Text("\(post.likes) likes")
                
                Spacer()
            }
            .padding(.bottom, 1)
            .padding(.top, 2)
            
            HStack{
                if let user = post.user {
                    
                    if post.caption != ""{
                        Text(user.username ?? "").fontWeight(.semibold) +
                        Text(": \(post.caption)")
                            .font(.callout)
                    }
                    
                    
                }
                Spacer()
            }.padding(.horizontal)
            
            HStack{
                
                Text("\(post.timestamp.formatted(.dateTime.day())) \(post.timestamp.formatted(.dateTime.month())), \(post.timestamp.formatted(.dateTime.hour().minute()))")
                    .font(.caption2)
                    .foregroundColor(.gray.opacity(0.7))
            
                Spacer()
            }.padding(.horizontal)
                .padding(.top, 1)
        }
    }
}

struct FeedCell_Previews: PreviewProvider {
    static var previews: some View {
        FeedCell(post: Post.MOCK_POSTS[2], edit: true)
    }
}




private extension FeedCell{
    
    
    var UserBar: some View {
        HStack {
            
            if let user = post.user {
                
                    NavigationLink{
                       
                        OtherProfileView(user: user)
                        
                    }label: {
                        
                        CircularProfileImageView(user: user)
                            .frame(width: 50, height: 50)
                            .padding(.horizontal)
                        
                        Text(user.username ?? "")
                            .bold()
                        .font(.title3)
                }
                
            }
            Spacer()
            
             
            Button{
                show = true
            }label: {
                Image(systemName: "ellipsis")
                    .padding(.horizontal)
            } .sheet(isPresented: $show) {
                
                
        
                if edit{
                    EditPostView(user: AuthService.shared.currentUser ?? UserModel.MOCK_USERS[0]) .presentationDetents(
                            [.medium, .large],
                            selection: $settingsDetent)
                }else{
                    DeleteConfirmationView()
                        .presentationDetents(
                            [.medium, .large],
                            selection: $settingsDetent)
                }
            }
            
        }
        .padding(.vertical, 4)
    }
}
