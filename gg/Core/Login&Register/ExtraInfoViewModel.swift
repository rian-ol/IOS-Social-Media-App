//
//  ExtraInfoViewModel.swift
//  gg
//
//  Created by Rian O'Leary on 09/08/2023.
//

import Foundation
import Firebase

class ExtraInfoViewModel: ObservableObject {
    @Published var takenUsernames = [String]()
    
    
    init(){
        Task{try await fetchAllUsernames()}
    }
    
    
    @MainActor
    func fetchAllUsernames() async throws{

        
        Firestore.firestore().collection("usernames").getDocuments(){
            (QuerySnapshot, err) in
            if let err = err {
                print(err)
            }else
            {
                for document in QuerySnapshot!.documents{
                    self.takenUsernames.append(document.documentID)
                }
            }
        }
        
        
    }
    
    func verifyAvailability(username: String) -> Bool{
        if username.count < 4 {return false}
        for i in 0..<takenUsernames.count{
            if username == takenUsernames[i]{
                return false
            }
        }
        return true
    }
}
