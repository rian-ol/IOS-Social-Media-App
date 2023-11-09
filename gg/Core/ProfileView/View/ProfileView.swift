//
//  ProfileView.swift
//  gg
//
//  Created by Rian O'Leary on 23/07/2023.
//

import SwiftUI
import Kingfisher

struct ProfileView: View {
    
    let user: UserModel
    
    private let gridItems: [GridItem] = [
        .init(.flexible(), spacing: 1),
        .init(.flexible(), spacing: 1),
        .init(.flexible(), spacing: 1)
    ]
     
    
    @StateObject var viewModel: PostGridVM
    init(user: UserModel) {
        self.user = user
        self._viewModel = StateObject(wrappedValue: PostGridVM(user: user))
    }
    
    private let imageDimension: CGFloat = (UIScreen.main.bounds.width / 3) - 1
    
    var body: some View {
        NavigationView{
            ZStack(alignment: .bottomLeading) {
                VStack{
                    VStack{
                        HStack {
                            CircularProfileImageView(user: user)
                                .frame(width: 150, height: 150)
                                .padding()
                            
                            Text(user.username ?? "")
                            
                            Spacer()
                        }
                        
                        Divider()
                    }
                    
                    
                    ScrollView {
                        LazyVGrid(columns: gridItems, spacing: 1){
                            ForEach(viewModel.posts) { post in
                                
                                NavigationLink{
                                    IndividualPostView(post: post, edit: true)
                                        
                                }label:{
                                    KFImage(URL(string: post.imageUrl))
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: imageDimension, height: imageDimension)
                                        .clipped()
                                }
                                    
                            }
                        }
                    }
                    .navigationDestination(for: Post.self, destination: {
                        post in
                        
                        IndividualPostView(post: post, edit: true)
                    })
                   
                    
                    
                   
                    
                    
                    NavigationLink(destination: PostView()
                        .navigationBarBackButtonHidden(true)) {
                        AddContentBubble()
                            .foregroundColor(Color("TextColor"))
                    }
                        .padding(.bottom)
                        .padding(.trailing, 300)
                }
                }
                .navigationTitle("Profile")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem {
                        NavigationLink{
                            ProfileSettingsView(user: user)
                            .navigationBarBackButtonHidden(true)
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
        
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(user: UserModel.MOCK_USERS[0])
    }
}
