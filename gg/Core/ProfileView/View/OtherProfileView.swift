//
//  ProfileView.swift
//  gg
//
//  Created by Rian O'Leary on 23/07/2023.
//

import SwiftUI
import Kingfisher

struct OtherProfileView: View {
    
    let user: UserModel
    
    @StateObject var viewModel: PostGridVM
    @StateObject var OUviewModel: OUserViewModel
    
    private let gridItems: [GridItem] = [
        .init(.flexible(), spacing: 1),
        .init(.flexible(), spacing: 1),
        .init(.flexible(), spacing: 1)
    ]
     
    
    init(user: UserModel) {
        self.user = user
        self._viewModel = StateObject(wrappedValue: PostGridVM(user: user))
        self._OUviewModel = StateObject(wrappedValue: OUserViewModel(user: user))
    }
    
    
    private let imageDimension: CGFloat = (UIScreen.main.bounds.width / 3) - 1
    
    var body: some View {
        
            VStack{
                VStack{
                    HStack {
                        CircularProfileImageView(user: user)
                            .frame(width: 150, height: 150)
                            .padding()
                        
                        VStack(spacing: 60) {
                            Text(user.username ?? "")
                                .padding(.top, 40)
                            
                            
                            
                            if(!user.isCurrentUser) {
                                HStack(alignment: .bottom ,spacing: 20){
                                    
                                    
                                    if let userPref = OUviewModel.userPref{
                                        
                                        if userPref.FriendOpt == true {
                                            if OUviewModel.friendStatus == .normal{
                                                Button {
                                                  Task  {
                                                      try await OUviewModel.addFriend(potFriendid: userPref.id)
                                                    }
                                                    OUviewModel.friendStatus = .request
                                                }label: {
                                                    Image(systemName: "person.badge.plus")
                                                        .resizable()
                                                        .frame(width: 30, height: 30)
                                                    .scaledToFit()
                                                }
                                                    .foregroundColor(.gray)
                                                    
                                            }
                                            else if OUviewModel.friendStatus == .request {
                                                Button{
                                                    Task{
                                                        try await OUviewModel.removeFriend(potFriendid: userPref.id)
                                                    }
                                                    OUviewModel.friendStatus = .normal
                                                }label: {
                                                    Image(systemName: "person.badge.plus")
                                                        .resizable()
                                                        .frame(width: 30, height: 30)
                                                    .scaledToFit()
                                                }
                                                .foregroundColor(.green)
                                            }else{
                                                Button{
                                                    Task{
                                                        try await OUviewModel.removeFriend(potFriendid: userPref.id)
                                                    }
                                                    OUviewModel.friendStatus = .normal
                                                }label: {
                                                    Image(systemName: "person.fill")
                                                        .resizable()
                                                        .frame(width: 30, height: 30)
                                                    .scaledToFit()
                                                }
                                                .foregroundColor(.green)
                                            }
                                        }
                                        
                                        
                                        
                                        if userPref.RelationshipOpt == true {
                                            if OUviewModel.relationshipStatus == .normal{
                                                Button {
                                                    Task{
                                                        try await OUviewModel.addRelation(potRelationship: userPref.id)
                                                    }
                                                    OUviewModel.relationshipStatus = .request
                                                }label: {
                                                    Image(systemName: "heart")
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(width: 30, height: 30)
                                                        .padding(.horizontal)
                                            }.foregroundColor(.gray)
                                                    
                                            }
                                            else if OUviewModel.relationshipStatus == .request {
                                                Button {
                                                    Task{
                                                        try await OUviewModel.removeRelationship(potFriendid: userPref.id)
                                                    }
                                                    OUviewModel.relationshipStatus = .normal
                                                }label: {
                                                    Image(systemName: "heart")
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(width: 30, height: 30)
                                                        .padding(.horizontal)
                                            }.foregroundColor(.green)
                                            }else{
                                                Button {
                                                    
                                                    Task{
                                                        try await OUviewModel.removeRelationship(potFriendid: userPref.id)
                                                    }
                                                    OUviewModel.relationshipStatus = .normal
                                                   
                                                }label: {
                                                    Image(systemName: "heart.fill")
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(width: 30, height: 30)
                                                        .padding(.horizontal)
                                            }.foregroundColor(.green)
                                            }
                                        }
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        if userPref.LinkOpt {
                                            if OUviewModel.linkStatus == .normal{
                                                Button {
                                                    Task{
                                                        try await OUviewModel.addLink(potLink: userPref.id)
                                                    }
                                                    OUviewModel.linkStatus = .request
                                                }label: {
                                                    Image(systemName: "link")
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(width: 30, height: 30)
                                                }.foregroundColor(.gray)
                                                
                                            }
                                            else if OUviewModel.linkStatus == .request {
                                                Button {
                                                    Task{
                                                        try await OUviewModel.removeLink(potFriendid: userPref.id)
                                                    }
                                                    OUviewModel.linkStatus = .normal
                                                }label: {
                                                    Image(systemName: "link")
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(width: 30, height: 30)
                                                }.foregroundColor(.green)
                                            }else{
                                                Button {
                                                    Task{
                                                        try await OUviewModel.removeLink(potFriendid: userPref.id)
                                                    }
                                                    OUviewModel.linkStatus = .normal
                                                    
                                                }label: {
                                                    Image(systemName: "link")
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(width: 30, height: 30)
                                                }.foregroundColor(.green)
                                            }
                                        }
                                    }
                                }
                            }
                            
                        }
                        
                        
                        
                        Spacer()
                    }
                    
                    Divider()
                }

                ScrollView {
                    LazyVGrid(columns: gridItems, spacing: 1){
                        ForEach(viewModel.posts) { post in
                            
                            NavigationLink{
                                IndividualPostView(post: post, edit: false)
                                    
                            }label:{
                                KFImage(URL(string: post.imageUrl))
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: imageDimension, height: imageDimension)
                                    .clipped()
                            }
                                
                        }
                    }
                }.navigationDestination(for: Post.self, destination: {
                    post in
                    
                    IndividualPostView(post: post, edit: false)
                })

                
                
            }
            .onAppear(){
                Task{
                    OUviewModel.getUserPrefs(withUid: user.id)
                }
            }
            .navigationTitle(user.isCurrentUser ? "Profile"  : "\(user.username ?? "")")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem {
                    Button{
                        
                    }label:{
                        Image(systemName: "line.3.horizontal")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 10, height: 10)
                            .padding(.top, 30)
                            .padding()
                            .foregroundColor(Color("TextColor"))
                        
                    }
                }
            }
    }
}

struct OtherProfileView_Previews: PreviewProvider {
    static var previews: some View {
        OtherProfileView(user: UserModel.MOCK_USERS[0])
    }
}
