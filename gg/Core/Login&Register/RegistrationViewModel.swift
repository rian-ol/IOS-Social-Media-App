//
//  RegistrationViewModel.swift
//  gg
//
//  Created by Rian O'Leary on 27/07/2023.
//

import Foundation
import SwiftUI
import FirebaseAuth
import FirebaseCore


class RegistrationViewModel: ObservableObject{
        
    @Published var email = ""
    @Published var password = ""
    @Published var pass1 = ""
    @Published var pass2 = ""
    @Published var college = "University Of Limerick"
    @Published var collegeList = ["University Of Limerick" , "University Of Galway"]
    @AppStorage("email-link") var emailLink: String?
    @Published var username = ""
    @Published var imageUrl: Image?
    
    
    
    
    func createUser() async throws{
        try await AuthService.shared.createUser(email: email, password: password, college: college)
    }
    
    
}



