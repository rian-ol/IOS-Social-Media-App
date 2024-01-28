//
//  UploadPostViewModel.swift
//  gg
//
//  Created by Rian O'Leary on 05/08/2023.
//

import Foundation
import PhotosUI
import SwiftUI
import Firebase


@MainActor
class UploadPostViewModel: ObservableObject {
    
    
    @Published var selectedImage: PhotosPickerItem? {
        didSet {Task {await loadImage(fromItem: selectedImage)}}
    }
    @Published var postImage: Image?
    
    private var uiImage: UIImage?
    
    
    func loadImage(fromItem item: PhotosPickerItem?) async {
        guard let item = item else {return}
                
        guard let data = try? await item.loadTransferable(type: Data.self) else {return}
        guard let uiImage = UIImage(data: data) else {return}
        self.uiImage = uiImage
        self.postImage = Image(uiImage: uiImage)
        
    }
    
    
    func uploadPost(caption: String, friend: Bool, link: Bool, relationship: Bool, global: Bool) async throws {
        
        guard let uid = Auth.auth().currentUser?.uid else {return}
        guard let uiImage = uiImage else {return}
        
        
        let postRef = Firestore.firestore().collection("posts").document()
        guard let imageUrl = try await ImageLoader.uploadImage(image: uiImage, pathName: "post_images") else {return}
        let post = Post(id: postRef.documentID, ownerUid: uid, caption: caption, likes: 0, imageUrl: imageUrl, timestamp: Date(), friendview: friend, linkview: link, relview: relationship, global: global)
        guard let encodedPost = try? Firestore.Encoder().encode(post) else {return}
   
        
        try await postRef.setData(encodedPost)
    }
}
