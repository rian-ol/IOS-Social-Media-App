//
//  ProfileSettingsView.swift
//  gg
//
//  Created by Rian O'Leary on 24/07/2023.
//

import SwiftUI


struct ProfileSettingsView: View {
    
    
    
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: ProfileSettingsViewModel
    @State var showDelete = false
    @State private var settingsDetent = PresentationDetent.medium
    
    init(user: UserModel){
        self._viewModel = StateObject(wrappedValue: ProfileSettingsViewModel(user: user))
    }
    
    var body: some View {
            VStack {
                
                HStack {
                    Image(systemName: "chevron.left")
                    Text("Profile")
                        .onTapGesture {
                            dismiss()
                        }
                    Spacer()
                }
                    .padding(.bottom, 15)
                    .padding(.horizontal)
                    .padding(.top)
                    
                
                VStack{
                    
                    
                    HStack{
                        Text("Your account")
                            .font(.title2)
                            .bold()
                        Spacer()
                    }.padding(.horizontal)
                        .padding(.bottom, 15)
                    
                    
                    VStack{
                        NavigationLink {
                            EditProfileView(user: viewModel.user).navigationBarBackButtonHidden(true)
                        } label: {
                            HStack {
                                VStack(alignment: .leading)  {
                                    Text("Edit Profile")
                                        .foregroundColor(Color("TextColor"))
                                    Text("Change your profile image")
                                        .foregroundColor(.gray)
                                        .font(.caption2)
                                }
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(Color("TextColor"))
                            }.padding(.horizontal)
                            
                        }
                    }
                    .padding(.bottom, 15)
                    
                    Divider()
                    
                    VStack{
                        NavigationLink{
                            ChangeOptsView(user: viewModel.user)
                                .navigationBarBackButtonHidden(true)
                        }label: {
                            HStack{
                            VStack(alignment: .leading) {
                                Text("Change your opt-ins")
                                    .foregroundColor(Color("TextColor"))
                                Text("Change who can connect with you")
                                    .foregroundColor(.gray)
                                    .font(.caption2)
                            }
                                
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(Color("TextColor"))
                            }.padding(.horizontal)
                        }
                    }
                    .padding(.vertical, 7.5)
                    
                }
                
                
                
                Divider()
                
                
                VStack{
                    
                    HStack{
                        Text("Authentication")
                            .font(.title2)
                            .bold()
                        Spacer()
                    }.padding(.horizontal)
                        .padding(.bottom, 15)
                    
                    
                    
                        Button{
                            
                            showDelete = true
                            
                        }label: {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("Delete Account")
                                        .foregroundColor(Color("TextColor"))
                                    Text("Permanently delete your account")
                                        .foregroundColor(.gray)
                                        .font(.caption2)
                                }
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .foregroundColor(Color("TextColor"))
                                
                            }.padding(.horizontal)
                        }
                        .padding(.vertical, 7.5)
                        .sheet(isPresented: $showDelete) {
                            DeleteConfirmationView()
                                .presentationDetents(
                                    [.medium, .large],
                                    selection: $settingsDetent)
                        }
                       
                    Divider()
                        
                            Button{
                                
                                AuthService.shared.signOut()
                                
                            }label: {
                                Text("Logout")
                                    .foregroundColor(Color("TextColor"))
                                    .modifier(EntryButton())
                        
                        }
                            .padding(.top, 35)
                    }.padding(.top, 15)
                    
               Spacer()
                
              
                    
                    
            }
//            .padding(.top, 70)
//            .ignoresSafeArea()
            
        }
    
}

struct ProfileSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSettingsView(user: UserModel.MOCK_USERS[0])
    }
}
