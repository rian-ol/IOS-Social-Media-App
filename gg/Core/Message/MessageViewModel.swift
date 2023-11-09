//
//  MessageViewModel.swift
//  gg
//
//  Created by Rian O'Leary on 19/08/2023.
//

import Foundation
import Firebase


class MessageViewModel: ObservableObject {
    
    let friend: Friend
    @Published private(set) var messages: [Message] = []
    @Published private(set) var lastmessageID = ""
    
    
    let db = Firestore.firestore()
    
    init(friend: Friend) {
        self.friend = friend
        getMessages(withUid: friend.id)
    }
    
    func getMessages(withUid uid: String){
        
        if let userID = AuthService.shared.currentUser?.id{
            db.collection("messages").document(userID).collection("friendMessages").whereField("userID", isEqualTo: uid).addSnapshotListener{ querySnapshot, error in
                guard let documents = querySnapshot?.documents else {
                    print("Error \(String(describing: error))")
                    return
                }
                self.messages = documents.compactMap { document -> Message? in
                    do {
                        return try document.data(as: Message.self)
                    }catch {
                        print("Error \(error)")
                        return nil
                    }
                }
                self.messages.sort{ $0.timestamp < $1.timestamp }
                
                if let id = self.messages.last?.id {
                    self.lastmessageID = id
                }
            }
        }
    }
    
    func sendMessage(text: String, receiverID: String){
        do{
            if let senderID = AuthService.shared.currentUser?.id{
                let newMessageSender = Message(id: UUID().uuidString, text: text, received: true, timestamp: Date(), userID: senderID)
                let newMessageReceiver = Message(id: UUID().uuidString, text: text, received: false, timestamp: Date(), userID: receiverID)
                
                try db.collection("messages").document(receiverID).collection("friendMessages").document().setData(from: newMessageSender)
                try db.collection("messages").document(senderID).collection("friendMessages").document().setData(from: newMessageReceiver)
            }
        }catch{
            print("error \(error)")
        }
    }
}
    

