//
//  LoginView.swift
//  MySportsRecordIOS
//
//  Created by Ásmundur Óskar Ásmundsson on 19.12.2022.
//

import SwiftUI

struct LoginView: View {
    @State var username: String = ""
    @State var password: String = ""
    var body: some View {
        VStack {
            Text("Login")
                .font(.title)
            Spacer()
            Form {
                Section("Input") {
                    TextField(text: $username, prompt: Text("Username")) {
                        Text("Required")
                    }
                    SecureField(text: $password, prompt: Text("Password")) {
                        Text("Required")
                    }
                }
                Button("Login") {
                    print("Logic that performs the login")
                }
            }
            Spacer()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
