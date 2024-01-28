//
//  ImageUploader.swift
//  gg
//
//  Created by Rian O'Leary on 06/08/2023.
//

import UIKit
import Firebase
import FirebaseStorage


struct ImageLoader {
    
    static func uploadImage(image: UIImage, pathName: String) async throws -> String? {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {return nil}
        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/\(pathName)/\(filename)")
        
        do{
            let _ = try await ref.putDataAsync(imageData)
            let url = try await ref.downloadURL()
            return url.absoluteString
        }catch{
            print("fail to upload \(error.localizedDescription)" )
            return nil
        }
    }
}
