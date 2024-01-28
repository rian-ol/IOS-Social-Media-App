//
//  AccountPreAuthLanding.swift
//  gg
//
//  Created by Rian O'Leary on 23/07/2023.
//

import SwiftUI

struct AccountPreAuthLanding: View {
    
    @State var isClicked = false
    
    var body: some View {
        
        
        
        
        VStack (spacing: 50){
            
            Text("Almost done!")
                .font(.largeTitle)
                .foregroundColor(Color(.systemGreen))
                .padding(.top, 50)
            
            Spacer()
            
            Text("Thanks for creating an account, please check your email to verify your account.")
                .font(.headline)
            .multilineTextAlignment(.center)
            
            
            VStack{
                if(!isClicked){
                    Text("Didn't get the email? ")
                    Button {
                        Task{ try await Task.sleep(nanoseconds: UInt64(6.0 * Double(NSEC_PER_SEC)))
                            await AuthService.shared.emailVerification()
                            
                        }
                    }label: {
                        Text("Resend email")
                            .modifier(EntryButton())
                            .onTapGesture {
                                isClicked = true
                            }
                    }
                }else{
                    Text("Another email has been sent.")
                    
                }
                
                
                Text("Verified your account? Click here to log in.")
                    .fontWeight(.semibold)
                    .padding(.top)
                    .onTapGesture {
                        AuthService.shared.signOut()
                    }
                
            }
            
            Spacer()
            
        }
        
        
    }
}

struct AccountPreAuthLanding_Previews: PreviewProvider {
    static var previews: some View {
        AccountPreAuthLanding()
    }
}
