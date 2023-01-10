//
//  UserView.swift
//  MySportsRecordIOS
//
//  Created by Ásmundur Óskar Ásmundsson on 19.12.2022.
//

import SwiftUI

struct UserProfileView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var authenticationViewModel: AuthenticationViewModel
    
    var body: some View {
        ScrollView {
            LazyVStack {
                Text("User profile")
                    .font(.title)
                if userViewModel.user != nil && authenticationViewModel.loggedIn {
                    UserView(user: userViewModel.user!)
                } else {
                    Text("")
                        .frame(height: 200)
                    Text("No one is logged in")
                }
            }
        }
        .onAppear {
            userViewModel.getUser()
        }
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
            .environmentObject(UserViewModel())
            .environmentObject(AuthenticationViewModel())
    }
}
