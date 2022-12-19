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
            Button(action: { navigationManager.viewType = .main }) {
                Label("Home", systemImage: "figure.gymnastics")
            }
            .padding(.top)
            Button(action: { navigationManager.viewType = .login }) {
                Label("Login", systemImage: "lock.open")
            }
            Button(action: { navigationManager.viewType = .signup }) {
                Label("Signup", systemImage: "person.badge.plus")
            }
            Button(action: { navigationManager.viewType = .settings }) {
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
