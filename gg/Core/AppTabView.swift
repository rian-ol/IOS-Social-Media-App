//
//  TabView.swift
//  gg
//
//  Created by Rian O'Leary on 23/07/2023.
//

import SwiftUI

struct AppTabView: View {
    let user: UserModel
    
//    init(user: UserModel){
//        self.user = user
//        let transparentAppearance = UITabBarAppearance()
//        transparentAppearance.configureWithTransparentBackground()
//        UITabBar.appearance().standardAppearance = transparentAppearance
//    }
    
    var body: some View {
        TabView{
            
            ProfileView(user: user)
                .tabItem {
                Image(systemName: "person")
            }
                
            ChatView(user: user)
                .tabItem {
                Image(systemName: "bubble.right")
            }
            
            
            HomeView()
                .tabItem {
                Image(systemName: "house")
            }
            
            
            
        }
        .accentColor(Color("TextColor"))
    }
}

extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        true
    }
}



struct AppTabView_Previews: PreviewProvider {
    static var previews: some View {
        AppTabView(user: UserModel.MOCK_USERS[0])
    }
}

