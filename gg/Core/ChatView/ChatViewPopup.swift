//
//  ChatViewPopup.swift
//  gg
//
//  Created by Rian O'Leary on 25/07/2023.
//

import SwiftUI

struct ChatViewPopup: View {
    var body: some View {
        VStack(spacing: .zero){
            icon            title
            content
        }
            .padding()
            .multilineTextAlignment(.center)
            .background(.pink)
    }
}

struct ChatViewPopup_Previews: PreviewProvider {
    static var previews: some View {
        ChatViewPopup()
    }
}


private extension ChatViewPopup {
    var icon: some View{
        Image(systemName: "info")
            .symbolVariant(.circle.fill)
            .font(.system(size: 50, weight: .bold, design: .rounded))
            .foregroundStyle(.white)
    }
    
    var title: some View {
        Text("Text here")
            .font(.system(size: 30, weight: .bold, design: .rounded))
            .padding()
    }
    
    
    var content: some View{
        Text("Some more text")
            .font(.callout)
            .foregroundColor(.black.opacity(0.8))
    }
    
    
}
