//
//  HomeView.swift
//  gg
//
//  Created by Rian O'Leary on 23/07/2023.
//

import SwiftUI

struct HomeView: View {
    
    @State private var FeedOrExplore = true
    @State var isSearch = false
    @StateObject var viewModel = FeedViewModel()
    
    var body: some View {
        
        NavigationStack{
            
            if(!isSearch){
            
            HStack {
                
                
                VStack {
                    
                    if(FeedOrExplore){
                        VStack{
                            Text("Feed")
                                .font(.title2)
                                .bold()
                            
                            Rectangle()
                                .fill(Color("TextColor"))
                                .frame(width: (UIScreen.main.bounds.width / 2) - 100, height: 4)
                        }
                    }else{
                        VStack{
                            Text("Feed")
                                .font(.title2)
                            
                            Rectangle()
                                .fill(.gray)
                                .frame(width: (UIScreen.main.bounds.width / 2) - 100, height: 0.5)
                        }
                    }
                }.onTapGesture {
                    if(!FeedOrExplore){
                        FeedOrExplore = true
                    }
                }
                
                
                VStack{
                    if(FeedOrExplore){
                        VStack{
                            Text("Explore")
                                .font(.title2)
                            Rectangle()
                                .frame(width: (UIScreen.main.bounds.width / 2) - 100, height: 0.5)
                        }
                        
                    }else{
                        VStack{
                            Text("Explore")
                                .font(.title2)
                                .bold()
                            Rectangle()
                                .fill(Color("TextColor"))
                                .frame(width: (UIScreen.main.bounds.width / 2) - 100, height: 4)
                        }
                    }
                }.onTapGesture {
                    if(FeedOrExplore){
                        FeedOrExplore = false
                    }
                }
                
                
                
            }
            .padding(.top, 40)
            
            
            
            
            if(FeedOrExplore){
                
                if viewModel.feed.count == 0{
                    Text("No posts available to show")
                }
                
                ScrollView{
                    
                    
                    LazyVStack(spacing: 40){
                        ForEach(viewModel.feed){ post in
                            FeedCell(post: post, edit: false)
                            Divider()
                        }
                    }
                }.refreshable {
                   
                }
                Divider()
                    .overlay(Color("ColorText"))
            }else{
                
                Text("Search...")
                    .foregroundColor(.gray)
                    .modifier(SearchBarText())
                    .onTapGesture {
                        isSearch = true
                    }
                
                ScrollView{
                    LazyVStack(spacing: 40){
                        ForEach(viewModel.explore){ post in
                            FeedCell(post: post, edit: false)
                            Divider()
                        }
                    }
                }.refreshable {
                    Task{
                        try await viewModel.fetchPosts()
                    }
                }
                
                Divider()
                    .overlay(Color("ColorText"))
                
            }
            
            
            }
            
            
            else{
                SearchBarView()
            }
            
        
            
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
