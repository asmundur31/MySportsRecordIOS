//
//  UserItemView.swift
//  MySportsRecordIOS
//
//  Created by Ásmundur Óskar Ásmundsson on 19.12.2022.
//

import SwiftUI

struct UserItemView: View {
    var user: User
    var place: Int

    var body: some View {
        VStack {
            Divider()

            HStack {
                Text("\(place).")
                Text(user.username)
                Spacer()
                Text(String(format: "%.2f", user.score))
            }
        }
    }
}

struct UserItemView_Previews: PreviewProvider {
    static var previews: some View {
        UserItemView(user: User(username: "Ási", email: "asmundur31@gmail.com", birthday: "1998-10-31", gender: "Male", nationality: "Iceland", club: "Brommagymnasterna", score: 12.3), place: 1)
    }
}
