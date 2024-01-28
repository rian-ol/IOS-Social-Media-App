//
//  CollegeSelection.swift
//  gg
//
//  Created by Rian O'Leary on 23/07/2023.
//

import SwiftUI

struct CollegeSelection: View {
    
    
    @Environment(\.dismiss) var dismiss
    @StateObject var registrationViewModel = RegistrationViewModel()
    
    var body: some View {
        VStack {
            
                Text("Select your college:")
                    .font(.title2)
                    .fontWeight(.semibold)
            
            Picker("Pick a college", selection: $registrationViewModel.college){
                ForEach(0..<registrationViewModel.collegeList.count, id: \.self) {
                    Text(self.registrationViewModel.collegeList[$0]).tag(self.registrationViewModel.collegeList[$0])
                }
            }
            .pickerStyle(.inline)
            
            
            
            NavigationLink{
                RegisterPage()
                    .environmentObject(registrationViewModel).navigationBarBackButtonHidden(true)
            }label: {
                Text("Continue")
                    .modifier(EntryButton())
                    
            }
            
        } .toolbar{
            ToolbarItem(placement: .navigationBarLeading) {
                Image(systemName: "chevron.left")
                    .imageScale(.large)
                    .onTapGesture {
                        dismiss()
                    }
                
            }
        }
    }
}

struct CollegeSelection_Previews: PreviewProvider {
    static var previews: some View {
        CollegeSelection()
    }
}
