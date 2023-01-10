//
//  NavigationTabView.swift
//  MySportsRecordIOS
//
//  Created by Ásmundur Óskar Ásmundsson on 19.12.2022.
//

import SwiftUI

struct NavigationTabView: View {
    var body: some View {
        TabView {
            RanklistView()
                .tabItem() {
                    Image(systemName: "list.number")
                    Text("Ranklist")
                }
            NewsfeedView()
                .tabItem() {
                    Image(systemName: "house")
                    Text("Newsfeed")
                }
            UserProfileView()
                .tabItem() {
                    Image(systemName: "person")
                    Text("User info")
                }
        }
        .background(Color(.lightGray).cornerRadius(8))
    }
}

struct NavigationTabView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationTabView()
            .environmentObject(RanklistsViewModel())
    }
}
