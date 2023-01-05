//
//  AuthenticationViewModel.swift
//  MySportsRecordIOS
//
//  Created by Ásmundur Óskar Ásmundsson on 5.1.2023.
//

import Foundation

class AuthenticationViewModel: ObservableObject {
    @Published var userCreated: Bool = false
    @Published var signupError: Bool = false
    
    func signUp(username: String, email: String, password: String, birthday: Date, gender: String, nationality: String, club: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        let birthdayString = dateFormatter.string(from: birthday)
        
        let body: [String: Any] = [
            "username": username,
            "email": email,
            "password": password,
            "nationality": nationality,
            "club": club,
            "birthday": birthdayString,
            "gender": gender,
        ]
        Network.shared.request(method: "POST", url: "http://localhost:3001/register", body: body, type: String.self) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    // Parse the data
                    print(data)
                    self.userCreated = true
                case .failure(let error):
                    switch error {
                    case Network.NetworkError.noInternet:
                        print("No internet")
                    case Network.NetworkError.clientError:
                        print("Client error")
                    case Network.NetworkError.statusNotSuccess:
                        if "\(error)".contains("409") {
                            self.signupError = true
                        }
                    case Network.NetworkError.decodeError:
                        print("Decode error")
                    case Network.NetworkError.urlError:
                        print("Url error")
                    case Network.NetworkError.nilInput:
                        print("Nil input")
                    default:
                        break
                    }
                }
            }
        }
    }
}
