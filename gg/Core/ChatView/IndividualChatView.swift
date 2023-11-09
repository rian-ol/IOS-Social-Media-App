//
//  IndividualChatView.swift
//  gg
//
//  Created by Rian O'Leary on 19/08/2023.
//

import SwiftUI

struct IndividualChatView: View {
    
    let friend: Friend
    @StateObject private var viewModel: MessageViewModel
    @Environment(\.dismiss) var dismiss
    @State private var message = ""
    
    init(friend:Friend){
        self.friend = friend
        self._viewModel = StateObject(wrappedValue: MessageViewModel(friend: friend))
    }
    
    
    var body: some View {
        
        VStack{
            
            HStack{
                
                HStack{
                    Image(systemName: "chevron.left")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 15, height: 15)
                        .onTapGesture {
                            dismiss()
                        }
                }.padding(.leading)
                    
                
                
                if let user = friend.user{
                    CircularProfileImageView(user: user)
                        .frame(width: 75, height: 75)
                        .padding(.horizontal)
                    
                    VStack(alignment: .leading){
                        
                        Text(user.username ?? "")
                            .font(.title2)
                            .bold()
                        
                        Text("Matched: \(friend.timestamp.formatted(.dateTime.day())) \(friend.timestamp.formatted(.dateTime.month()))")
                            .font(.footnote)
                            .foregroundColor(.gray)
                        
                        
                    }
                }
                
                Spacer()
                
                Button{
                    
                }label: {
                    Image(systemName: "ellipsis")
                        .padding(.horizontal)
                        .foregroundColor(Color("TextColor"))
                }
                .padding(.trailing, 5)
                
                
            }
            .frame(height: 80)
            .padding(.top)
           
            Divider()
            
            ScrollView{
                ForEach(viewModel.messages, id: \.id){ message in
                    if message.received{
                        HStack{
                            Text(message.text)
                                .modifier(ReceivedMessage())
                                .padding(.horizontal)
                            Spacer()
                        }
                    }else{
                        HStack{
                            Spacer()
                            Text(message.text)
                                .modifier(SentMessage())
                                .padding(.horizontal)
                        }
                    }
                }
            }
            
            
            HStack{
                
                
                TextField("Text", text: $message)
                    .multilineTextAlignment(.leading)
                    .modifier(smallTextInputEdit())
                    .padding(.leading, 40)
                
                Button{
                    viewModel.sendMessage(text: message, receiverID: friend.id)
                    message = ""
                }label: {
                    
                    Text("Send")
                        .modifier(ShortEntryButton())
                        .padding(.horizontal)
                        
                }
                
            }
            
            
        }
        .toolbar(.hidden, for: .tabBar)
    }
}

struct IndividualChatView_Previews: PreviewProvider {
    static var previews: some View {
        IndividualChatView(friend: Friend.MOCK_FRIENDS[1])
    }
}
