//
//  ChatView.swift
//  gg
//
//  Created by Rian O'Leary on 23/07/2023.
//

import SwiftUI

struct ChatView: View {
    
    @State private var FriendOrRand = true
    let messages = [["Hello", 0], ["How are you"],["Hope to see you later"] as [Any]]
    @State private var enteredText = ""
    @State private var showPicker = false
    @State private var showChatSelect = false
    @State private var settingsDetent = PresentationDetent.medium
    
    
    
    @StateObject var viewModel: FriendViewModel
    let user: UserModel
    
    init(user: UserModel){
        self.user = user
        self._viewModel = StateObject(wrappedValue: FriendViewModel(user: user))
    }
    
    var body: some View {
        
        NavigationStack {
            
            HStack {
                VStack {
                    
                    if(FriendOrRand){
                        VStack{
                            Text("Friends")
                                .font(.title2)
                                .bold()
                            
                            Rectangle()
                                .fill(Color("TextColor"))
                                .frame(width: (UIScreen.main.bounds.width / 2) - 100, height: 4)
                        }
                    }else{
                        VStack{
                            Text("Friends")
                                .font(.title2)
                            
                            Rectangle()
                                .fill(.gray)
                                .frame(width: (UIScreen.main.bounds.width / 2) - 100, height: 0.5)
                        }
                    }
                }.onTapGesture {
                    if(!FriendOrRand){
                        FriendOrRand = true
                    }
                }
                
                VStack{
                    if(FriendOrRand){
                        VStack{
                            Text("Random")
                                .font(.title2)
                            Rectangle()
                                .frame(width: (UIScreen.main.bounds.width / 2) - 100, height: 0.5)
                        }
                        
                    }else{
                        VStack{
                            Text("Random")
                                .font(.title2)
                                .bold()
                            Rectangle()
                                .fill(Color("TextColor"))
                                .frame(width: (UIScreen.main.bounds.width / 2) - 100, height: 4)
                        }
                    }
                }.onTapGesture {
                    if(FriendOrRand){
                        FriendOrRand = false
                    }
                }
                
                
                
            }
            .padding(.top, 40)
            
            
            Divider()
            
            if(FriendOrRand){
                
                VStack{
                    
                    
                   
                    
                    
                    
                    Picker("", selection: $viewModel.picker) {
                        ForEach(chatTypes.allCases) { value in
                            Text(value.id.capitalized)

                        }
                    }.foregroundColor(Color("TextColor"))
                    .pickerStyle(.menu)
                        .onChange(of: viewModel.picker) { newValue in
                            showPicker.toggle()

                        }
                    
                    
                    if viewModel.picker == "Friend"{
                        ScrollView{
                            ForEach(viewModel.friends){ friend in
                                
                                NavigationLink{
                                    IndividualChatView(friend: friend)
                                        .navigationBarBackButtonHidden(true)
                                }label:{
                                    FriendsListBox(friend: friend)
                                        .padding(.top)
                                }
                                
                            }
                        }
                        .navigationDestination(for: Friend.self, destination: {
                            friend in
                            
                            IndividualChatView(friend: friend)
                        })
                    }
                    
                    
                    
                    if viewModel.picker == "Link"{
                        ScrollView{
                            ForEach(viewModel.links){ friend in
                                
                                NavigationLink{
                                    IndividualChatView(friend: friend)
                                        .navigationBarBackButtonHidden(true)
                                }label:{
                                    FriendsListBox(friend: friend)
                                        .padding(.top)
                                }
                                
                            }
                        }
                        .navigationDestination(for: Friend.self, destination: {
                            friend in
                            
                            IndividualChatView(friend: friend)
                        })
                    }
                    
                    
                    
                    if viewModel.picker == "Relationship"{
                        ScrollView{
                            ForEach(viewModel.relationships){ friend in
                                
                                NavigationLink{
                                    IndividualChatView(friend: friend)
                                        .navigationBarBackButtonHidden(true)
                                }label:{
                                    FriendsListBox(friend: friend)
                                        .padding(.top)
                                }
                                
                            }
                        }
                        .navigationDestination(for: Friend.self, destination: {
                            friend in
                            
                            IndividualChatView(friend: friend)
                        })
                    }
                    
                    
                    }.toolbar(.visible, for: .tabBar)
                    
                
                
                
                
                
                
                
                
            }else{
                
                VStack{
                    
                    Text("User")
                        .font(.largeTitle)
                
                    ScrollView{
                        
                        Text("-Male \n-20 \n-Business")
                            .modifier(GreyBackground())
                        
                        
                        HStack {
                            
                            Spacer()
                            
                            Text("This is a test")
                                .modifier(SentMessage())
                        }.padding(.horizontal)
                        
                        
                        HStack{
                            
                            Text("This is a reply to the test")
                                .modifier(ReceivedMessage())
                            
                            Spacer()
                            
                        }.padding(.horizontal)
                    
                }
                    
                    Spacer()
                    
                    Divider()
                    
                    
                    HStack{
                      
                        
                        TextField("Text", text: $enteredText)
                            .multilineTextAlignment(.leading)
                            .padding(.leading)
                        
                        Button{
                            
                        }label: {
                            
                            Text("Send")
                                .modifier(ShortEntryButton())
                                .padding(.horizontal)
                                .padding(.top, 4)
                                
                        }
                        
                    }
                    
                }.toolbar(.hidden, for: .tabBar)
                
                
            }
                Spacer()
                
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(user: UserModel.MOCK_USERS[0])
    }
}
