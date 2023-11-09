//
//  Login Page.swift
//  gg
//
//  Created by Rian O'Leary on 23/07/2023.
//

import SwiftUI

struct Login_Page: View {
    
    
    @StateObject var viewModel = LoginViewModel()
    
    var body: some View {
        
        NavigationStack {
            VStack (spacing: 20) {
                
                Spacer()
                
                VStack {
                    Image("logo")
                        .resizable()
                        .scaledToFill()
                    .frame(width: 200, height: 200)
                }.padding(.bottom, 100)
                
                
                VStack (spacing: 15){
                    TextField("Email" , text: $viewModel.email)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled(true)
                    .modifier(TextInputEdit())
                    
                    
                    SecureField("Password"
                                , text: $viewModel.password)
                    .modifier(TextInputEdit())
                    
                }
                
                
                
                Button{
                    Task {
                        try await viewModel.signIn()
                    }
                } label: {
                    Text("Login")
                        .modifier(EntryButton())
                }
                
                NavigationLink{
                    
                }label: {
                    HStack {
                        Spacer()
                        
                        Text("Forgot Password?")
                            .font(.caption)
                            .foregroundColor(Color(.systemGreen))
                            .padding(.horizontal)
                    }
                        
                }.padding(.top)
                
                

                Spacer()
                
                NavigationLink{
                    CollegeSelection().navigationBarBackButtonHidden(true)
                }label: {
                    Text("Need to make an account?")
                        .foregroundColor(Color(.systemGreen))
                        
                }
                
            }
        }
        
        
        
    }
}

struct Login_Page_Previews: PreviewProvider {
    static var previews: some View {
        Login_Page()
    }
}
