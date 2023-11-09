//
//  SelectChatView.swift
//  gg
//
//  Created by Rian O'Leary on 26/08/2023.
//

import SwiftUI

struct SelectChatView: View {
    
    @StateObject private var viewModel: FriendViewModel
    @State private var user: UserModel
    
    init(user: UserModel) {
        self._user = State(initialValue: user)
        self._viewModel = StateObject(wrappedValue: FriendViewModel(user: user))
    }
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack{
            
            Text("Select chat type:")
                .bold()
                .font(.title)
            
            Text(viewModel.picker)
            
            Button{
                viewModel.setPicker(type: "Friend")
                dismiss()
            }label:{
                Text("Friend")
                    .font(.title2)
                    .foregroundColor(Color("TextColor"))
            }.padding()
            
            
            Button{
                viewModel.setPicker(type: "Link")
                dismiss()
            }label:{
                Text("Link")
                    .font(.title2)
                    .foregroundColor(Color("TextColor"))
            }.padding()
            
            
            Button{
                viewModel.setPicker(type: "Relationship")
                dismiss()
            }label:{
                Text("Relationship")
                    .font(.title2)
                    .foregroundColor(Color("TextColor"))
            }.padding()
          
        }
    }
}

struct SelectChatView_Previews: PreviewProvider {
    static var previews: some View {
        SelectChatView(user: UserModel.MOCK_USERS[0])
    }
}
