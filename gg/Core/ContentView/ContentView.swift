//
//  ContentView.swift
//  gg
//
//  Created by Rian O'Leary on 23/07/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()
    var body: some View {
        Group{
            if (viewModel.userSession == nil ){
                Login_Page()
                
            }else if(viewModel.userSession != nil && viewModel.userSession?.isEmailVerified == false){
                AccountPreAuthLanding()
                
            }else if let currentUser = viewModel.currentUser{
                if (currentUser.username == "") {
                   ExtraInfoView(user: currentUser)
                }
                else{
                    AppTabView(user: currentUser)
                }
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
