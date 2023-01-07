//
//  UserView.swift
//  MySportsRecordIOS
//
//  Created by Ásmundur Óskar Ásmundsson on 19.12.2022.
//

import SwiftUI

struct UserView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var authenticationViewModel: AuthenticationViewModel
    
    var body: some View {
        VStack {
            if userViewModel.user != nil && authenticationViewModel.loggedIn {
                Text("Username: \(userViewModel.user!.username)")
                Text("Gender: \(userViewModel.user!.gender)")
                Text("Birthday: \(userViewModel.user!.birthday)")
                Text("Nationality: \(userViewModel.user!.nationality ?? "")")
                Text("Club: \(userViewModel.user!.club ?? "")")
                Text("Score: \(userViewModel.user!.score)")
            } else {
                Text("No one is logged in")
            }
        }
        .onAppear {
            userViewModel.getUser()
        }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
            .environmentObject(UserViewModel())
            .environmentObject(AuthenticationViewModel())
    }
}
