//
//  ProfileSettingsViewModel.swift
//  gg
//
//  Created by Rian O'Leary on 06/08/2023.
//

import Firebase
import FirebaseAuth
import PhotosUI
import SwiftUI



@MainActor
class ProfileSettingsViewModel: ObservableObject {
    
    
    @Published var userSession = Auth.auth().currentUser
    @Published var user: UserModel
    @Published var userPref: UserPref?
    
    @Published var friendToggle: Bool = false
    @Published var linkToggle: Bool = false
    @Published var relationshipToggle = false
    @Published var randomToggle = false
    @Published var everyoneToggle = false
    
    @Published var selectedImage: PhotosPickerItem? {
        didSet {Task {await loadImage(fromItem: selectedImage)}}
    }
    
    
    
    @Published var profileImage: Image?
    @Published var uiImage: UIImage?
    @Published var selecteduiImage: UIImage?{
        didSet {Task { await loadImage(item: selecteduiImage)}}
    }
    @Published var username = ""
    
    
    init(user: UserModel) {
        self.user = user
        Task{
            try await getUserPrefs(uid: user.id)
        }
        
       
    }
    
    func loadImage(fromItem item: PhotosPickerItem?) async {
        guard let item = item else {return}
                
        guard let data = try? await item.loadTransferable(type: Data.self) else {return}
        guard let uiImage = UIImage(data: data) else {return}
        self.uiImage = uiImage
        self.profileImage = Image(uiImage: uiImage)
        
    }
    
    func loadImage(item: UIImage?) async {
        guard let item = item else {return}
        self.uiImage = item
        self.profileImage = Image(uiImage: item)
    }
    
    @MainActor
    func updateUserData() async throws{
        
        var data = [String: Any]()
        
        if let uiImage = uiImage {
            let imageUrl = try? await ImageLoader.uploadImage(image: uiImage, pathName: "profile_images")
            data["profileImageUrl"] = imageUrl
        }
        
        if !username.isEmpty && username != user.username{
            
            data["username"] = username
            
            var i = [String: Any]()
            
            i["uid"] = user.id
            try await Firestore.firestore().collection("usernames").document(username).setData(i)
            try await Firestore.firestore().collection("users").document(user.id).updateData(["keywordsforlookup": user.keywordsforlookup])
            self.user = try await userService.fetchUser(withUid: user.id)
        }
        
        if !data.isEmpty {
            try await Firestore.firestore().collection("users").document(user.id).updateData(data)
            self.user = try await userService.fetchUser(withUid: user.id)
            try await Firestore.firestore().collection("users").document(user.id).updateData(["keywordsforlookup": user.keywordsforlookup])
            print(user.keywordsforlookup)
        }
    }
    
    
     func changeOpts(authType: String, changedValue: Bool) async{
        
        guard let userid = userSession?.uid else {return}
        guard let encodedValue = try? Firestore.Encoder().encode(changedValue) else {return}
        try? await Firestore.firestore().collection("users/\(userid)").document(authType).setData(encodedValue)
        
    }
  
    func getAllPrefs(uid: String){
        var userPrefArray: [UserPref] = []
        Firestore.firestore().collection("userPref").addSnapshotListener{ querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                return
            }
            userPrefArray = documents.compactMap{ document -> UserPref? in
                do{
                    return try document.data(as: UserPref.self)
                }catch{
                    return nil
                }
            }
        }
        
        for i in 0 ..< userPrefArray.count {
            if userPrefArray[i].id == uid{
                
                self.userPref = userPrefArray[i]
            }
        }
        findBoolValues()
        
    }
    
    
    
    func getUserPrefs(uid: String) async throws {
        let snapshot = try await Firestore.firestore().collection("userPref").document(uid).getDocument()
        self.userPref =  try snapshot.data(as: UserPref.self)
        
        findBoolValues()
        
    }
    
    
    func findBoolValues(){
        if userPref?.FriendOpt == true{
            self.friendToggle = true
        }else{
            self.friendToggle = false
        }
        
        if userPref?.LinkOpt == true{
            self.linkToggle = true
        }else{
            self.linkToggle = false
        }
            
        if userPref?.RelationshipOpt == true{
            self.relationshipToggle = true
        }else{
            self.relationshipToggle = false
        }
        
        if userPref?.RandomOpt  == true{
            self.randomToggle = true
        }else{
            self.randomToggle = false
        }
    }
    
    
}
