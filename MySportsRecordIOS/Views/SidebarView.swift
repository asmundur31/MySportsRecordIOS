//
//  SidebarView.swift
//  MySportsRecordIOS
//
//  Created by Ásmundur Óskar Ásmundsson on 19.12.2022.
//

import SwiftUI

struct SidebarView: View {
    @ObservedObject var navigationManager : SidebarNavigationManager
    @EnvironmentObject var authenticationViewModel : AuthenticationViewModel

    var body: some View {
        VStack {
            Text("My Sports Record")
                .font(.title2)
            Button {
                navigationManager.viewType = .main
            } label: {
                Label("Home", systemImage: "figure.gymnastics")
                    .padding()
            }
            .foregroundColor(.black)
            .background(Color(red:225/255, green: 255/255, blue: 228/255).cornerRadius(8))            .padding(.top)
            if !authenticationViewModel.loggedIn {
                Button {
                    navigationManager.viewType = .login
                } label: {
                    Label("Login", systemImage: "lock.open")
                        .padding()
                }
                .foregroundColor(.black)
                .background(Color(red:225/255, green: 255/255, blue: 228/255).cornerRadius(8))
                .padding(.top)
            } else {
                Button {
                    authenticationViewModel.logout()
                } label: {
                    Label("Logout", systemImage: "lock")
                        .padding()
                }
                .foregroundColor(.black)
                .background(Color(red:225/255, green: 255/255, blue: 228/255).cornerRadius(8))
                .padding(.top)
            }
            
            Button {
                navigationManager.viewType = .signup
            } label: {
                Label("Signup", systemImage: "person.badge.plus")
                    .padding()
            }
            .foregroundColor(.black)
            .background(Color(red:225/255, green: 255/255, blue: 228/255).cornerRadius(8))
            .padding(.top)
            Spacer()
        }
    }
}

struct SidebarView_Previews: PreviewProvider {
    static var previews: some View {
        SidebarView(navigationManager: SidebarNavigationManager())
            .environmentObject(AuthenticationViewModel())
    }
}
