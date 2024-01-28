//
//  ExtraInfoView.swift
//  gg
//
//  Created by Rian O'Leary on 07/08/2023.
//

import SwiftUI
import PhotosUI
import PhotoSelectAndCrop

struct ExtraInfoView: View {
    
    @StateObject private var viewModel: ProfileSettingsViewModel
    @StateObject private var eiViewModel = ExtraInfoViewModel()
    @StateObject private var liViewModel = LoginViewModel()
    @State var image: ImageAttributes = ImageAttributes(withSFSymbol: "person.crop.circle.fill")
    @State var confirmImage = false
    @State var editMode = true
    let size: CGFloat = 220
    @State var signedUp = false
    
    init(user: UserModel){
        self._viewModel = StateObject(wrappedValue: ProfileSettingsViewModel(user: user))
    }
    
    var body: some View {
        
        if (!signedUp){
        VStack {
            

            
            ImagePane(image: image, isEditMode: $editMode)
                .frame(width: size, height: size)
                .padding(.bottom)
                
            
            if !compareAtts(image) && !confirmImage {
                Button{
                    viewModel.selecteduiImage = image.croppedImage
                    confirmImage.toggle()
                    editMode.toggle()
                }label: {
                    VStack{
                        Text("Confirm your photo")
                            .modifier(LongEntryButton())
                        Text("You can change your profile picture again later.")
                            .font(.caption2)
                            .foregroundColor(Color("TextColor").opacity(0.4))
                    }
                }
            }
            
            
            
            
            TextField("Username" , text: $viewModel.username)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled(true)
                .modifier(TextInputEdit())
            
            
            if eiViewModel.verifyAvailability(username: viewModel.username){
                if viewModel.selecteduiImage != nil {
                    
                    Button{
                        Task{try await viewModel.updateUserData()}
                        signedUp.toggle()
                        
                    } label: {
                        Text("Create Account")
                            .modifier(EntryButton())
                    }.padding()
                    
                }else{
                    Text("Please ensure you have selected a profile image.")
                        .padding(.top, 40)
                        .padding(.horizontal)
                        .multilineTextAlignment(.center)
                }
                
            }else{
                
                Text("This username is not valid/available.")
                    .padding(.top, 40)
                    .padding(.horizontal)
                    .multilineTextAlignment(.center)
                
            }
            
        }
        
        
    }
        else{
            AppTabView(user: viewModel.user)
        }
    }
}

struct ExtraInfoView_Previews: PreviewProvider {
    static var previews: some View {
        ExtraInfoView(user: UserModel.MOCK_USERS[0])
    }
}


func compareAtts(_ image1: ImageAttributes) -> Bool{
    return image1.image == Image(systemName: "person.crop.circle.fill")
}
