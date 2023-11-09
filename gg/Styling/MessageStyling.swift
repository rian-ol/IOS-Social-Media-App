//
//  MessageStyling.swift
//  gg
//
//  Created by Rian O'Leary on 24/07/2023.
//

import SwiftUI

struct ReceivedMessage: ViewModifier{
    
    func body(content: Content) -> some View {
        content
            .padding()
            .background(.gray)
            .foregroundColor(.white)
            .cornerRadius(16)
            .listRowSeparator(.hidden)
//            .overlay(alignment: .bottomLeading) {
//                Image(systemName: "arrowtriangle.down.fill")
//                    .foregroundColor(.gray)
//                    .font(.title)
//                    .rotationEffect(.degrees(45))
//                    .offset(x: -10, y:10)
//            }
    }
}


struct SentMessage: ViewModifier{
    
    func body(content: Content) -> some View {
        content
            .padding()
            .background(.green)
            .foregroundColor(.white)
            .cornerRadius(16)
            .listRowSeparator(.hidden)
//            .overlay(alignment: .bottomTrailing) {
//                Image(systemName: "arrowtriangle.down.fill")
//                    .foregroundColor(.green)
//                    .font(.title)
//                    .rotationEffect(.degrees(-45))
//                    .offset(x: 10, y:10)
//            }
    }
}


struct GreyBackground: ViewModifier{
    
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color(.lightGray))
            .foregroundColor(.white)
            .cornerRadius(16)
            .listRowSeparator(.hidden)
    }
}
