//
//  LoginView.swift
//  MySportsRecordIOS
//
//  Created by Ásmundur Óskar Ásmundsson on 19.12.2022.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authenticationViewModel: AuthenticationViewModel

    @State var email: String = ""
    @State var password: String = ""
    var body: some View {
        VStack {
            Text("Login")
                .font(.title)
            Spacer()
            Form {
                Section("Input") {
                    TextField("Email", text: $email)
                    SecureField("Password", text: $password)
                }
                Button("Login") {
                    authenticationViewModel.login(email: email, password: password)
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
