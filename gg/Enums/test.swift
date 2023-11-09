//
//  test.swift
//  gg
//
//  Created by Rian O'Leary on 04/08/2023.
//

import SwiftUI



struct test: View {
    
    
    @State private var selection: String = "M"
    let genderRange = ["M", "F", "FF"]
    var body: some View {
        VStack{
            Text("Select")
            Text("Selected: \(selection)")
            
            Picker("Select gender", selection: $selection){
                ForEach(0..<genderRange.count){
                    Text(self.genderRange[$0]).tag(self.genderRange[$0])
                }
            }
        }
    }
}

struct test_Previews: PreviewProvider {
    static var previews: some View {
        test()
    }
}
