//
//  UserProfileView.swift
//  MySportsRecordIOS
//
//  Created by Ásmundur Óskar Ásmundsson on 9.1.2023.
//

import SwiftUI

struct UserView: View {
    var user: User
    
    var body: some View {
        VStack {
            Text("\(user.username)")
                .font(.title)
            Text("\(user.email)")
                .font(.subheadline)
            VStack {
                HStack {
                    Text("\(user.gender)")
                    Spacer()
                    Text("\(user.nationality ?? "")")
                }
                HStack {
                    Text("\(user.birthday)")
                    Spacer()
                    Text("\(user.club ?? "")")
                }
            }
            .padding()
            Text(String(format: "Total score: %.2f", user.score))
                .font(.title2)
            Spacer()
            NavigationView {
                List {
                    NavigationLink("Trampet") {
                        UserTrampetView()
                            .navigationTitle("Trampet")
                    }
                    /*NavigationLink("Tumbling") {
                        UserTumblingView()
                            .navigationTitle("Tumbling")
                    }
                    NavigationLink("Floor") {
                        UserFloorView()
                            .navigationTitle("Floor")
                    }*/
                }
            }
            .padding(.bottom)
        }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(user: User(username: "Ásmundur", email: "asmundur31@gmail.com", birthday: "1998-10-31", gender: "Male", score: 0.0))
            .environmentObject(UserViewModel())
    }
}
