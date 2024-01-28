//
//  EditProfileView.swift
//  gg
//
//  Created by Rian O'Leary on 06/08/2023.
//

import SwiftUI
import PhotosUI
import PhotoSelectAndCrop

struct EditProfileView: View {
    
    @StateObject private var viewModel: ProfileSettingsViewModel
    @Environment(\.dismiss) var dismiss
    @State var image: ImageAttributes = ImageAttributes(withSFSymbol: "person.crop.circle.fill")
    let size: CGFloat = 220
    
    init(user: UserModel){
        self._viewModel = StateObject(wrappedValue: ProfileSettingsViewModel(user: user))
    }
    
    
    var body: some View {
        VStack {
            HStack{
                HStack{
                    Image(systemName: "chevron.left")
                    Text("Cancel")
                }
                .padding()
                .onTapGesture {
                    dismiss()
                }
                Spacer()
                
                HStack{
                    Button{
                            viewModel.uiImage = image.croppedImage
                            Task{try await viewModel.updateUserData()}
                            dismiss()
                        
                    } label:{
                        Text("Confirm")
                    }
                       
                }.padding(.trailing)
            }
            
            ImagePane(image: image, isEditMode: .constant(true))
                .frame(width: size, height: size)
                .padding(.bottom)
            
            
            
            
                
            
//            if compareAtts(image) && confirmImage {
//                Button{
//                    viewModel.selecteduiImage = image.croppedImage
//                    confirmImage.toggle()
//                    editMode.toggle()
//                }label: {
//                    VStack{
//                        Text("Confirm your photo")
//                            .modifier(LongEntryButton())
//                        Text("You can change your profile picture again later.")
//                            .font(.caption2)
//                            .foregroundColor(Color("TextColor").opacity(0.4))
//                    }
//                }
//            }
                
            
            Spacer()
        }
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView(user: UserModel.MOCK_USERS[0])
    }
}
