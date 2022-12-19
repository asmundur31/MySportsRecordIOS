//
//  SignUpView.swift
//  MySportsRecordIOS
//
//  Created by Ásmundur Óskar Ásmundsson on 19.12.2022.
//

import SwiftUI

struct SignUpView: View {
    @State var username: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var confirmPassword: String = ""
    
    @State var country: String = ""
    @State var club: String = ""
    @State var birthday: Date = Date()
    @State var gender = ["Man", "Woman", "Other"]
    @State var selectedGender = ""
    
    var body: some View {
        VStack {
            Text("Signup")
                .font(.title)
            Spacer()
            Form {
                Section("Contact details") {
                    TextField(text: $username, prompt: Text("Username")) {
                        Text("Required")
                    }
                    SecureField(text: $email, prompt: Text("Email")) {
                        Text("Required")
                    }
                    SecureField(text: $password, prompt: Text("Password")) {
                        Text("Required")
                    }
                    SecureField(text: $confirmPassword, prompt: Text("Confirm password")) {
                        Text("Required")
                    }
                }
                Section("Personal details") {
                    TextField(text: $country, prompt: Text("Country")) {
                        
                    }
                    TextField(text: $club, prompt: Text("Club")) {
                        
                    }
                    DatePicker(
                            "Date of birth",
                            selection: $birthday,
                            displayedComponents: [.date]
                        )
                    .datePickerStyle(.graphical)
                    Picker("Choose a gender", selection: $selectedGender) {
                        ForEach(gender, id: \.self) { item in
                            Text(item)
                        }
                    }
                    .onChange(of: selectedGender) { newGender in
                        selectedGender = newGender
                    }
                }
                
                Button("Signup") {
                    print("Logic that performs the signup")
                }
            }
            Spacer()
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
