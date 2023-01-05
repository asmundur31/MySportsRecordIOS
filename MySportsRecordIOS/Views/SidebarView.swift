//
//  SidebarView.swift
//  MySportsRecordIOS
//
//  Created by Ásmundur Óskar Ásmundsson on 19.12.2022.
//

import SwiftUI

struct SidebarView: View {
    @ObservedObject var navigationManager : SidebarNavigationManager

    var body: some View {
        VStack {
            Text("My Sports Record")
                .font(.title2)
            Button {
                navigationManager.viewType = .main
            } label: {
                Label("Home", systemImage: "figure.gymnastics")
            }
            .padding(.top)
            Button {
                navigationManager.viewType = .login
            } label: {
                Label("Login", systemImage: "lock.open")
            }
            Button {
                navigationManager.viewType = .signup
            } label: {
                Label("Signup", systemImage: "person.badge.plus")
            }
            Button {
                navigationManager.viewType = .settings
            } label: {
                Label("Settings", systemImage: "gear")
            }
            Spacer()
        }
    }
}

struct SidebarView_Previews: PreviewProvider {
    static var previews: some View {
        SidebarView(navigationManager: SidebarNavigationManager())
    }
}
