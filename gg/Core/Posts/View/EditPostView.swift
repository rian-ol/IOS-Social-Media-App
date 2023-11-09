//
//  EditPostView.swift
//  gg
//
//  Created by Rian O'Leary on 28/08/2023.
//

import SwiftUI

struct EditPostView: View {
    
    @StateObject private var viewModel: ProfileSettingsViewModel
    @State private var friend = false
    @State private var link = false
    @State private var relationship = false
    @State private var globe = false
    
    init(user:UserModel){
        self._viewModel = StateObject(wrappedValue: ProfileSettingsViewModel(user: user))
    }
    
    var body: some View {
        VStack{
            
            VStack{
                Text("Change who can view your post:")
                    .bold()
                
                HStack{
                    Button {
                        
                        viewModel.friendToggle.toggle()
                    } label: {
                        Image(systemName: "person.fill")
                            .resizable()
                            .frame(width: 28, height: 28)
                            .padding(.horizontal)
                            .foregroundColor(viewModel.friendToggle ? .green : .gray)
                    }
                    
                    
                    Button {
                        viewModel.relationshipToggle.toggle()
                    } label: {
                        Image(systemName: "heart.fill")
                            .resizable()
                            .frame(width: 28, height: 28)
                            .padding(.horizontal)
                            .foregroundColor(viewModel.relationshipToggle ? .green : .gray)
                    }
                    
                    
                    Button {
                        viewModel.linkToggle.toggle()
                    } label: {
                        Image(systemName: "link")
                            .resizable()
                            .frame(width: 28, height: 28)
                            .padding(.horizontal)
                            .foregroundColor(viewModel.linkToggle ? .green : .gray)
                    }
                    
                    
                    Button {
                        viewModel.everyoneToggle.toggle()
                    } label: {
                        Image(systemName: "globe")
                            .resizable()
                            .frame(width: 28, height: 28)
                            .padding(.horizontal)
                            .foregroundColor(viewModel.everyoneToggle ? .green : .gray)
                    }
                }
                
            }
            
            Button{
                
            }label: {
                Text("Confirm changes")                    .modifier(LengthlessEntryButton())
                    .padding()
            }
            
            
            Button{
                
            }label: {
                Text("Delete post")
                    .foregroundColor(.white)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding(.horizontal)
                    .background(Color(.red))
                    .cornerRadius(10)
                    
            }
            
        }
    }
}

struct EditPostView_Previews: PreviewProvider {
    static var previews: some View {
        EditPostView(user: UserModel.MOCK_USERS[0])
    }
}
