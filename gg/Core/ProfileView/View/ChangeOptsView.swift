//
//  ChangeOptsView.swift
//  gg
//
//  Created by Rian O'Leary on 18/08/2023.
//

import SwiftUI

struct ChangeOptsView: View {
    
    @StateObject var viewModel: ProfileSettingsViewModel
    
    
    init(user: UserModel){
        self._viewModel = StateObject(wrappedValue: ProfileSettingsViewModel(user: user))
    }
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        
        VStack{
            VStack{
                HStack{
                    HStack{
                        Image(systemName: "chevron.left")
                        Text("Cancel")
                    }
                    .padding()
                    .onTapGesture {
                        dismiss()
                    }
                    Spacer()
                    
                    HStack{
                        Button{
                            Task{try await viewModel.updateUserData()}
                            dismiss()
                        } label:{
                            Text("Done")
                        }
                           
                    }.padding(.trailing)
                }
            }.padding(.bottom, 20)
            
            
            VStack{
                
                
                
                
                VStack(spacing: 30){
                    HStack{
                        VStack(alignment: .leading){
                            Text("Friends")
                                .foregroundColor(Color("TextColor"))
                            Text("Opt in/out of new friends.")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        
                        Toggle("", isOn: $viewModel.friendToggle)
                    }.padding(.horizontal)
                
                    
                    
                    Divider()
                    
                    HStack{
                        VStack(alignment: .leading){
                            Text("Links")
                                .foregroundColor(Color("TextColor"))
                            Text("Opt in/out of new links.")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        
                        Toggle("", isOn: $viewModel.linkToggle)
                    }.padding(.horizontal)
                    
                    
                    
                    Divider()
                    
                    HStack{
                        VStack(alignment: .leading){
                            Text("Relationships")
                                .foregroundColor(Color("TextColor"))
                            Text("Opt in/out of new relationships.")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }.frame(width: 200)
                        
                        Toggle("", isOn: $viewModel.relationshipToggle)
                    }.padding(.trailing)
                        .padding(.leading, 5)
                    
                    
                    Divider()
                   
                    HStack{
                        VStack(alignment: .leading){
                            Text("Random")
                                .foregroundColor(Color("TextColor"))
                            Text("Opt in/out of new random chats.")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }.frame(width: 210)
                        
                        Toggle("", isOn: $viewModel.randomToggle)
                    }.padding(.trailing)
                        .padding(.leading, 5)
                    
                    
                    Divider()
                    
                  
                }
                
                
                
                VStack(spacing: 30){
                        Text("Opting out of Friend, Link and Relationship restricts other users from requesting these connections with your account.")
                            .font(.caption)
                            .bold()
                            .foregroundColor(Color("TextColor").opacity(0.6))
                            .frame(width: 380, alignment: .leading)
                    
                    
                        Text("When opting out of Random, you no longer get matched with random users to chat with")
                            .font(.caption)
                            .bold()
                            .foregroundColor(Color("TextColor").opacity(0.6))
                            .frame(width: 380, alignment: .leading)
                    }
                .padding(.vertical, 30)
            }
            Spacer()
        }
    }
}

struct ChangeOptsView_Previews: PreviewProvider {
    static var previews: some View {
        ChangeOptsView(user: UserModel.MOCK_USERS[0])
    }
}
