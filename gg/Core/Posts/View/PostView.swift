//
//  PostView.swift
//  gg
//
//  Created by Rian O'Leary on 05/08/2023.
//

import SwiftUI
import PhotosUI

struct PostView: View {
    
    @Environment(\.dismiss) var dismiss
    @State private var description = ""
    @State private var imagePickerPresented = false
    @State private var displayWarning = false
    @State var friend = false
    @State var link = false
    @State var relationship = false
    @State var globe = true
    
    @StateObject var viewModel = UploadPostViewModel()
    
   
    
    var body: some View {
        VStack{
            HStack {
                HStack{
                    Image(systemName: "chevron.left")
                    Text("Cancel")
                }
                .padding()
                .onTapGesture {
                    viewModel.postImage = nil
                    viewModel.selectedImage = nil
                    dismiss()
                }
                Spacer()
                
                HStack{
                    Text("Upload")
                        .onTapGesture {
                            
                            if !link && !relationship && !friend && !globe{
                                displayWarning.toggle()
                            }else{
                                Task {try await viewModel.uploadPost(caption: description, friend: friend, link: link, relationship: relationship, global: globe)}
                                viewModel.postImage = nil
                                viewModel.selectedImage = nil
                                dismiss()
                            }
                        }
                        
                }.padding()
            }
            .padding(.top)
            
            VStack{
                
                if let image = viewModel.postImage{
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: 200, maxHeight: 200)
                        .contentShape(Rectangle())
                        .clipped()
                        .onTapGesture {
                            imagePickerPresented.toggle()
                        }
                }else{
                    ZStack {
                        Rectangle()
                            .fill()
                            .foregroundColor(.gray)
                            .frame(width: 200, height: 200)
                        
                        Text("Select an image")
                            .foregroundColor(.white)
                    }.onTapGesture {
                        imagePickerPresented.toggle()
                    }
                }
                
                HStack{
                    Text("Who can view:")
                        .padding(.horizontal)
                    
                    
                    
                    Button {
                        
                        friend.toggle()
                    } label: {
                        Image(systemName: "person.fill")
                            .resizable()
                            .frame(width: 28, height: 28)
                            .padding(.horizontal)
                            .foregroundColor(friend ? .green : .gray)
                    }
                    
                    
                    Button {
                        relationship.toggle()
                    } label: {
                        Image(systemName: "heart.fill")
                            .resizable()
                            .frame(width: 28, height: 28)
                            .padding(.horizontal)
                            .foregroundColor(relationship ? .green : .gray)
                    }
                    
                    
                    Button {
                       link.toggle()
                    } label: {
                        Image(systemName: "link")
                            .resizable()
                            .frame(width: 28, height: 28)
                            .padding(.horizontal)
                            .foregroundColor(link ? .green : .gray)
                    }
                    
                    
                    Button {
                       globe.toggle()
                    } label: {
                        Image(systemName: "globe")
                            .resizable()
                            .frame(width: 28, height: 28)
                            .padding(.horizontal)
                            .foregroundColor(globe ? .green : .gray)
                    }
                    
                    Spacer()
                }.padding(.top)
                
                TextField("Description", text: $description, axis: .vertical)
                    .padding(.horizontal)
                    .padding(.top)
                
                
                if displayWarning{
                    Button{
                        displayWarning.toggle()
                    }label: {
                        Text("Please select who can view your post")
                            .modifier(LengthlessEntryButton())
                            .frame(width: 375, height: 100)
                    }
                    
                }
            }
            
            Spacer()
        }
        .photosPicker(isPresented: $imagePickerPresented, selection: $viewModel.selectedImage)
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView()
    }
}
