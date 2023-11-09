//
//  TextInputEdit.swift
//  gg
//
//  Created by Rian O'Leary on 23/07/2023.
//

import SwiftUI


struct TextInputEdit: ViewModifier{
    
    func body(content: Content) -> some View {
        content
        .font(.title3)
        .fontWeight(.semibold)
        .padding(.horizontal)
        .frame(width: 320, height: 40)
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
}

struct smallTextInputEdit: ViewModifier{
    
    func body(content: Content) -> some View {
        content
        .font(.title3)
        .fontWeight(.semibold)
        .padding(.horizontal)
        .frame(width: 250, height: 35)
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
}


struct EntryButton: ViewModifier{
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .font(.title3)
            .fontWeight(.semibold)
            .padding(.horizontal)
            .frame(width: 200, height: 35)
            .background(Color(.systemGreen))
            .cornerRadius(10)
    }
}

struct LongEntryButton: ViewModifier{
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .font(.title3)
            .fontWeight(.semibold)
            .padding(.horizontal)
            .frame(width: 250, height: 35)
            .background(Color(.systemGreen))
            .cornerRadius(10)
    }
}

struct LengthlessEntryButton: ViewModifier{
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .font(.title3)
            .fontWeight(.semibold)
            .padding(.horizontal)
            .background(Color(.systemGreen))
            .cornerRadius(10)
    }
}

struct ShortEntryButton: ViewModifier{
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .font(.headline)
            .fontWeight(.semibold)
            .padding(.horizontal)
            .frame(width: 75, height: 35)
            .background(Color(.systemGreen))
            .cornerRadius(10)
    }

}


struct SearchBarText: ViewModifier{
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .frame(width: 300, height: 40)
            .padding(.horizontal)
            .background(Color("TextColor").opacity(0.3))
            .cornerRadius(10)
    }
}


struct uploadPostButtons: ViewModifier{
    func body(content: Content) -> some View {
        content
            
    }
}
