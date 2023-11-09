//
//  Login Page.swift
//  gg
//
//  Created by Rian O'Leary on 23/07/2023.
//

import SwiftUI
import Firebase

struct RegisterPage: View {
    
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel : RegistrationViewModel
    
    
    var body: some View {
        
        
        VStack (spacing: 20) {
            
            Spacer()
            
            VStack{
             Text("Create a new account")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                
            }.padding(.bottom, 50)
            
        
            
            
            VStack (spacing: 15){
                TextField("Email" , text: $viewModel.email)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled(true)
                .modifier(TextInputEdit())
                
               
                
                SecureField("Password"
                            , text: $viewModel.pass1)
                .modifier(TextInputEdit())
                
                SecureField("Re-enter password"
                            , text: $viewModel.pass2)
                .modifier(TextInputEdit())
                
            }
            
            
            Button{
                
                if (viewModel.pass1 == viewModel.pass2 && viewModel.pass1.count > 7) {
                        viewModel.password = viewModel.pass1
                        Task{try await viewModel.createUser()}
                    }else{
                        
                    }
                   
                } label: {
                    Text("Create Account")
                        .modifier(EntryButton())
            }
            
            
           
            Spacer()
            
          
            
        }.toolbar{
            ToolbarItem(placement: .navigationBarLeading) {
                Image(systemName: "chevron.left")
                    .imageScale(.large)
                    .onTapGesture {
                        dismiss()
                    }
                
            }
        }
        
        
        
    }
}


struct RegisterPage_Previews: PreviewProvider {
    static var previews: some View {
        RegisterPage().environmentObject(RegistrationViewModel())
    }
}
