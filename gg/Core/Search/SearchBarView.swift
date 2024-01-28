//
//  SearchBarView.swift
//  gg
//
//  Created by Rian O'Leary on 03/08/2023.
//

import SwiftUI

struct SearchBarView: View {
    @State var searchText = ""
    @StateObject var viewModel = SearchViewModel()
    @State private var isSearch = true
    @FocusState private var isFocused: Bool
    //    @Environment(\.dismiss) var dismiss
    var body: some View {
        
        let keywordBinding = Binding<String>(
            
            get: {
                searchText
            },
            set:{
                searchText = $0
                viewModel.fetchUsers(from: searchText)
            }
        )
        
        
        if(isSearch){
        VStack{
            
            ActualSearchBar(searchText: keywordBinding)
                .focused($isFocused)
            
            if !isFocused{
//                HStack{
//                    Text("Recent searches")
//                        .font(.caption2)
//                        .bold()
//                        .padding(.horizontal, 35)
//                    Spacer()
//                }
                VStack(spacing: 15) {
                    ForEach(viewModel.searchedUsers){ user in
                        NavigationLink(value: user){
                            HStack{
                                CircularProfileImageView(user: user)
                                    .frame(width: 50, height: 50 )
                                
                                VStack(alignment: .leading) {
                                    Text(user.username!)
                                }
                                Spacer()
                            }
                            .padding(.horizontal)
                        }
                        
                    }
                }
            }
            
            
            ScrollView{
                
                LazyVStack(spacing: 15) {
                    ForEach(viewModel.users){ user in
                        NavigationLink(value: user){
                            HStack{
                                
                                CircularProfileImageView(user: user)
                                    .frame(width: 50, height: 50)
                                
                                VStack(alignment: .leading) {
                                    Text(user.username ?? "")
                                    
                                    
                                }
                                Spacer()
                            }
                            
                            
                            .padding(.horizontal)
                        }
                        
                    }
                }
                
            }.onTapGesture {
                
            }
            .navigationDestination(for: UserModel.self, destination: {
                user in
                    OtherProfileView(user: user)
            })
            
        }.toolbar {
            ToolbarItem (placement: .navigationBarLeading){
                HStack {
                    Image(systemName: "chevron.left")
                }.onTapGesture {
                    isSearch = false
                    
                    //                   dismiss()
                }
            }
        }
        
        }else{
            HomeView()
        }
    }

}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView()
    }
}

struct ActualSearchBar: View {
    @Binding var searchText: String
    
    var body: some View{
        HStack {
            TextField("Search ...", text: $searchText)
                .textInputAutocapitalization(.never)
                .modifier(SearchBarText())
                .autocorrectionDisabled(true)
            
        }.padding(.top, 20)
            .padding(.bottom, 15)
    }
}
