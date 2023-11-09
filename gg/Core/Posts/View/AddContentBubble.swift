//
//  AddContentBubble.swift
//  gg
//
//  Created by Rian O'Leary on 05/08/2023.
//

import SwiftUI

struct AddContentBubble: View {
    var body: some View {
        
        ZStack{
            
            Circle()
                .fill()
                .foregroundColor(.green)
                .frame(width: 60, height: 60)
            
            Image(systemName: "plus")
                .resizable()
                .scaledToFit()
                .frame(width: 35, height: 35)
        }
    }
}

struct AddContentBubble_Previews: PreviewProvider {
    static var previews: some View {
        AddContentBubble()
    }
}
