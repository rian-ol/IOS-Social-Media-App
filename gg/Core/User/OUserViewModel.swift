//
//  OUserViewModel.swift
//  gg
//
//  Created by Rian O'Leary on 16/08/2023.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift


class OUserViewModel: ObservableObject{
    
    
    @Published var userPref: UserPref?
    @Published var userPrefArray: [UserPref] = []
    @Published var user: UserModel
    @Published var friendStatus: FriendStatus?
    @Published var relationshipStatus: FriendStatus?
    @Published var linkStatus: FriendStatus?
    let db = Firestore.firestore()
    
    init(user: UserModel){
        self.user = user
        
        getAllPrefs()
        Task{try await getCurrentStatus(potFriendid: user.id)}
    }
    
    
    @MainActor
    func getUserPrefs(withUid uid: String){
        for i in 0 ..< userPrefArray.count {
            if userPrefArray[i].id == uid{
                userPref = userPrefArray[i]
            }
        }
    }
    
    
    func getAllPrefs() {
        db.collection("userPref").addSnapshotListener{ querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                return
            }
            self.userPrefArray = documents.compactMap{ document -> UserPref? in
                do{
                    return try document.data(as: UserPref.self)
                }catch{
                    return nil
                }
            }
        }
    }
    
    
    
    func addFriend(potFriendid: String) async throws {
   
       guard let uid = AuthService.shared.currentUser?.id else{ return }
       let snapshot = try await Firestore.firestore().collection("friends").document(uid).collection("friends").whereField("id", isEqualTo: potFriendid).getDocuments()
       if snapshot.isEmpty{
           let snap2 = try await Firestore.firestore().collection("friends").document(uid).collection("potFriend").whereField("id", isEqualTo: potFriendid).getDocuments()
           
           if snap2.isEmpty{
               
               let newFriendFriend = potFriend(id: potFriendid, timestamp: Date(), sentOrReceived: true)
              let newFriendUser = potFriend(id: uid, timestamp: Date(), sentOrReceived: false)

              try Firestore.firestore().collection("friends").document(uid).collection("potFriend").document(potFriendid).setData(from: newFriendFriend)

              try Firestore.firestore().collection("friends").document(potFriendid).collection("potFriend").document(uid).setData(from: newFriendUser)
               
           }else{
               
               {
                   let _ =   Firestore.firestore().collection("friends").document(uid).collection("potFriend").document(potFriendid).getDocument{ (doc, error ) in
                       guard let user = doc else{return}
                       
                       do{
                           let sent = user.data()?["sentOrReceived"] as? Bool
                           
                           if sent != true{
                               
                               
                               let newFriendFriend = Friend(id: potFriendid, timestamp: Date())
                               let newFriendUser = Friend(id: uid, timestamp: Date())
                               
                               try Firestore.firestore().collection("friends").document(uid).collection("friends").document(potFriendid).setData(from: newFriendFriend)
                               
                               try Firestore.firestore().collection("friends").document(potFriendid).collection("friends").document(uid).setData(from: newFriendUser)
                           }
                       }catch{
                           
                       }
                   }
               }()
                   
               
           }
           
       }
        
   }
    
    
    func addRelation(potRelationship: String) async throws {
   
       guard let uid = AuthService.shared.currentUser?.id else{ return }
       let snapshot = try await Firestore.firestore().collection("friends").document(uid).collection("relationships").whereField("id", isEqualTo: potRelationship).getDocuments()
       if snapshot.isEmpty{
           let snap2 = try await Firestore.firestore().collection("friends").document(uid).collection("potRelationship").whereField("id", isEqualTo: potRelationship).getDocuments()
           
           if snap2.isEmpty{

               let newFriendFriend = potFriend(id: potRelationship, timestamp: Date(), sentOrReceived: true)
              let newFriendUser = potFriend(id: uid, timestamp: Date(), sentOrReceived: false)

              try Firestore.firestore().collection("friends").document(uid).collection("potRelationship").document(potRelationship).setData(from: newFriendFriend)

              try Firestore.firestore().collection("friends").document(potRelationship).collection("potRelationship").document(uid).setData(from: newFriendUser)
               
           }else{
               
               {
                   let _ =   Firestore.firestore().collection("friends").document(uid).collection("potRelationship").document(potRelationship).getDocument{ (doc, error ) in
                       guard let user = doc else{return}
                       
                       do{
                           let sent = user.data()?["sentOrReceived"] as? Bool
                           
                           if sent != true{
                               
                               let newFriendFriend = Friend(id: potRelationship, timestamp: Date())
                               let newFriendUser = Friend(id: uid, timestamp: Date())

                               try Firestore.firestore().collection("friends").document(uid).collection("relationships").document(potRelationship).setData(from: newFriendFriend)

                               try Firestore.firestore().collection("friends").document(potRelationship).collection("relationships").document(uid).setData(from: newFriendUser)
                           }
                       }catch{
                           
                       }
                   }
               }()
            }
       }
        
   }
    
    
    func addLink(potLink: String) async throws {
   
       guard let uid = AuthService.shared.currentUser?.id else{ return }
       let snapshot = try await Firestore.firestore().collection("friends").document(uid).collection("links").whereField("id", isEqualTo: potLink).getDocuments()
       if snapshot.isEmpty{
           let snap2 = try await Firestore.firestore().collection("friends").document(uid).collection("potLink").whereField("id", isEqualTo: potLink).getDocuments()
           
           if snap2.isEmpty{

               let newFriendFriend = potFriend(id: potLink, timestamp: Date(), sentOrReceived: true)
              let newFriendUser = potFriend(id: uid, timestamp: Date(), sentOrReceived: false)

              try Firestore.firestore().collection("friends").document(uid).collection("potLink").document(potLink).setData(from: newFriendFriend)

              try Firestore.firestore().collection("friends").document(potLink).collection("potLink").document(uid).setData(from: newFriendUser)
               
           }else{
               
               {
                   let _ =   Firestore.firestore().collection("friends").document(uid).collection("potFriend").document(potLink).getDocument{ (doc, error ) in
                       guard let user = doc else{return}
                       
                       do{
                           let sent = user.data()?["sentOrReceived"] as? Bool
                           
                           if sent != true{
                               
                               let newFriendFriend = Friend(id: potLink, timestamp: Date())
                               let newFriendUser = Friend(id: uid, timestamp: Date())

                               try Firestore.firestore().collection("friends").document(uid).collection("links").document(potLink).setData(from: newFriendFriend)

                               try Firestore.firestore().collection("friends").document(potLink).collection("links").document(uid).setData(from: newFriendUser)
                           }
                       }catch{
                           
                       }
                   }
               }()
                
           }
           
       }
        
   }
    
    
    
    @MainActor
    func getCurrentStatus(potFriendid: String) async throws{
        
        guard let uid = AuthService.shared.currentUser?.id else{ return}
        
        //friends
        let snapshot = try await Firestore.firestore().collection("friends").document(uid).collection("friends").whereField("id", isEqualTo: potFriendid).getDocuments()
        let snap = try await Firestore.firestore().collection("friends").document(uid).collection("potFriend").whereField("id", isEqualTo: potFriendid).getDocuments()
        if snapshot.isEmpty{
            
            
            if snap.isEmpty{
                friendStatus = .normal
            }else{
                {
                    let _ =  Firestore.firestore().collection("friends").document(uid).collection("potFriend").document(potFriendid).getDocument{ (doc, error ) in
                        guard let user = doc else{return}
                        
                        let sent = user.data()?["sentOrReceived"] as? Bool
                        
                        if sent == true{
                            self.friendStatus = .request
                        }else
                        {
                            self.friendStatus = .normal
                        }
                        
                    }
                }()
            }
            
        }else{
            friendStatus = .friend
        }
        
        //relations
        let snapshot1 = try await Firestore.firestore().collection("friends").document(uid).collection("relationships").whereField("id", isEqualTo: potFriendid).getDocuments()
     
        
        if snapshot1.isEmpty{
            let snap1 = try await Firestore.firestore().collection("friends").document(uid).collection("potRelationship").whereField("id", isEqualTo: potFriendid).getDocuments()
            
            if snap1.isEmpty{
                relationshipStatus = .normal
            }else{
                
                {
                    let _ =  Firestore.firestore().collection("friends").document(uid).collection("potRelationship").document(potFriendid).getDocument{ (doc, error ) in
                        guard let user = doc else{return}
                        
                        let sent = user.data()?["sentOrReceived"] as? Bool
                        
                        if sent == true{
                            self.relationshipStatus = .request
                        }else
                        {
                            self.relationshipStatus = .normal
                        }
                        
                    }
                }()
            }
            
        }else{
            relationshipStatus = .friend
        }
        
        //links
        let snapshot2 = try await Firestore.firestore().collection("friends").document(uid).collection("links").whereField("id", isEqualTo: potFriendid).getDocuments()
        
        if snapshot2.isEmpty{
            let snap2 = try await Firestore.firestore().collection("friends").document(uid).collection("potLink").whereField("id", isEqualTo: potFriendid).getDocuments()
            
            if snap2.isEmpty{
                linkStatus = .normal
            }else{
                {
                    let _ =  Firestore.firestore().collection("friends").document(uid).collection("potLink").document(potFriendid).getDocument{ (doc, error ) in
                        guard let user = doc else{return}
                        
                        let sent = user.data()?["sentOrReceived"] as? Bool
                        
                        if sent == true{
                            self.linkStatus = .request
                        }else
                        {
                            self.linkStatus = .normal
                        }
                    }
                }()
            }
            
        }else{
            linkStatus = .friend
        }
        
    }
    
    
    func removeFriend(potFriendid: String) async throws{
        guard let uid = AuthService.shared.currentUser?.id else{ return }
        let snapshot = try await Firestore.firestore().collection("friends").document(uid).collection("friends").whereField("id", isEqualTo: potFriendid).getDocuments()
        
        if snapshot.isEmpty{
            
            let _ = try await Firestore.firestore().collection("friends").document(uid).collection("potFriends").document(potFriendid).delete()
            
            let _ = try await Firestore.firestore().collection("friends").document(potFriendid).collection("potFriends").document(uid).delete()
       
        }else{
            
            let _ = try await Firestore.firestore().collection("friends").document(uid).collection("friends").document(potFriendid).delete()
            
            let _ = try await Firestore.firestore().collection("friends").document(potFriendid).collection("friends").document(uid).delete()
        }
    }
    
    
    
    func removeRelationship(potFriendid: String) async throws{
        guard let uid = AuthService.shared.currentUser?.id else{ return }
        let snapshot = try await Firestore.firestore().collection("friends").document(uid).collection("relationships").whereField("id", isEqualTo: potFriendid).getDocuments()
        
        if snapshot.isEmpty{
            
            let _ = try await Firestore.firestore().collection("friends").document(uid).collection("potRelationship").document(potFriendid).delete()
            
            let _ = try await Firestore.firestore().collection("friends").document(potFriendid).collection("potRelationship").document(uid).delete()
       
        }else{
            
            let _ = try await Firestore.firestore().collection("friends").document(uid).collection("relationships").document(potFriendid).delete()
            
            let _ = try await Firestore.firestore().collection("friends").document(potFriendid).collection("relationships").document(uid).delete()
        }
    }
    
    
    func removeLink(potFriendid: String) async throws{
        guard let uid = AuthService.shared.currentUser?.id else{ return }
        let snapshot = try await Firestore.firestore().collection("friends").document(uid).collection("links").whereField("id", isEqualTo: potFriendid).getDocuments()
        
        if snapshot.isEmpty{
            
            let _ = try await Firestore.firestore().collection("friends").document(uid).collection("potLinks").document(potFriendid).delete()
            
            let _ = try await Firestore.firestore().collection("friends").document(potFriendid).collection("potLinks").document(uid).delete()
       
        }else{
            
            let _ = try await Firestore.firestore().collection("friends").document(uid).collection("links").document(potFriendid).delete()
            
            let _ = try await Firestore.firestore().collection("friends").document(potFriendid).collection("links").document(uid).delete()
        }
    }
    
    
}
