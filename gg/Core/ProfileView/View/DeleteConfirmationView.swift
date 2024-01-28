//
//  DeleteConfirmationView.swift
//  gg
//
//  Created by Rian O'Leary on 26/08/2023.
//

import SwiftUI

struct DeleteConfirmationView: View {
    var body: some View {
        
        
        
        VStack{
            
            Text("Are you sure you want to delete your account?")
                .bold()
            
            Button {
                Task{
                    try await AuthService.shared.deleteAccount()
                }
            } label: {
                Text("Yes DELETE")
                    .modifier(LengthlessEntryButton())
                    .frame(width: 200, height: 40)
            }
        }

        
    }
}

struct DeleteConfirmationView_Previews: PreviewProvider {
    static var previews: some View {
        DeleteConfirmationView()
    }
}
