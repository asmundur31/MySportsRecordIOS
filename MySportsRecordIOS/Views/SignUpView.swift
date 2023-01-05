//
//  SignUpView.swift
//  MySportsRecordIOS
//
//  Created by Ásmundur Óskar Ásmundsson on 19.12.2022.
//

import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var authenticationViewModel: AuthenticationViewModel
    
    @State var username: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var confirmPassword: String = ""
    
    @State var birthday: Date = Date()
    @State var gender = ["Choose gender", "Male", "Female", "Other"]
    @State var selectedGender = ""
    @State var nationality: String = ""
    @State var club: String = ""
    
    @State var usernameError = false
    @State var emailError = false
    @State var passError = false
    @State var birthdayError = false
    @State var genderError = false
    
    var body: some View {
        VStack {
            Text("Signup")
                .font(.title)
            Spacer()
            Form {
                Section("Contact details") {
                    TextField("Username (Required)", text: $username)
                        .onChange(of: username) { value in
                            usernameError = (value == "") ? true : false
                        }
                    if usernameError {
                        Text("Username can not be empty")
                            .foregroundColor(.red)
                    }
                    TextField("Email (Required)", text: $email)
                        .onChange(of: email) { value in
                            emailError = (value == "") ? true : false
                        }
                    if emailError {
                        Text("Email can not be empty")
                            .foregroundColor(.red)
                    }
                    SecureField("Password (Required)", text: $password)
                        .onChange(of: password) { value in
                            passError = false
                        }
                    SecureField("Confirm password (Required)", text: $confirmPassword)
                        .onChange(of: confirmPassword) { value in
                            passError = (value != password) ? true : false
                        }
                    if passError {
                        Text("Passwords can not be empty or do not match")
                            .foregroundColor(.red)
                    }
                }
                Section("Personal details") {
                    DatePicker(
                            "Date of birth (Required)",
                            selection: $birthday,
                            displayedComponents: [.date])
                        .datePickerStyle(.automatic)
                    Picker("Gender (Required)", selection: $selectedGender) {
                        ForEach(gender, id: \.self) { item in
                            Text(item)
                        }
                    }
                    .onChange(of: selectedGender) { newGender in
                        selectedGender = newGender
                        genderError = (newGender == "") ? true : false
                    }
                    if genderError {
                        Text("Gender can not be empty")
                            .foregroundColor(.red)
                    }
                    TextField("Nationality (Optional)", text: $nationality)
                    TextField("Club (Optional)", text: $club)
                }
                
                Button("Signup") {
                    authenticationViewModel.userCreated = false
                    authenticationViewModel.signupError = false
                    
                    usernameError = (username == "") ? true : false
                    emailError = (email == "") ? true : false
                    passError = (password == "") ? true : false
                    genderError = (selectedGender == "") ? true : false
                    
                    if !usernameError && !emailError && !passError && !genderError {
                        authenticationViewModel.signUp(username: username, email: email, password: password, birthday: birthday, gender: selectedGender, nationality: nationality, club: club)
                    }
                }
                if usernameError || emailError || passError || genderError {
                    Text("Fix errors before continuing")
                        .foregroundColor(.red)
                }
                if authenticationViewModel.userCreated {
                    Text("User was created successfully.")
                }
                if authenticationViewModel.signupError {
                    Text("User with this email already exists.")
                        .foregroundColor(.red)
                }
            }
            Spacer()
        }
        .onAppear {
            authenticationViewModel.userCreated = false
            authenticationViewModel.signupError = false
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
            .environmentObject(AuthenticationViewModel())
    }
}
