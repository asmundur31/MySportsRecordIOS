//
//  AuthenticationViewModel.swift
//  MySportsRecordIOS
//
//  Created by Ásmundur Óskar Ásmundsson on 5.1.2023.
//

import Foundation

class AuthenticationViewModel: ObservableObject {
    @Published var loggedIn: Bool = false
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
        Network.shared.request(method: "POST", url: "http://localhost:3001/register", body: body, token: nil, type: String.self) { result in
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
    
    func login(email: String, password: String) {
        let body: [String: Any] = [
            "email": email,
            "password": password,
        ]
        Network.shared.request(method: "POST", url: "http://localhost:3001/login", body: body, token: nil, type: TokenDTO.self) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    // Save the tokens to user defaults
                    UserDefaults.standard.set(data.accessToken, forKey: "accessToken")
                    UserDefaults.standard.set(data.refreshToken, forKey: "refreshToken")
                    self.loggedIn = true
                    print("User logged in successfully")
                    // Redirect to profile
                    // Todo
                case .failure(let error):
                    switch error {
                    case Network.NetworkError.noInternet:
                        print("No internet")
                    case Network.NetworkError.clientError:
                        print("Client error")
                    case Network.NetworkError.statusNotSuccess:
                        print("No success status")
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
    
    func logout() {
        let refreshToken = UserDefaults.standard.object(forKey: "refreshToken") as? String
        if refreshToken == nil {
            return
        }
        let body: [String: Any] = [
            "refreshToken": refreshToken!
        ]
        Network.shared.request(method: "DELETE", url: "http://localhost:3001/logout", body: body, token: nil, type: String.self) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    print(data)
                    // Remove the key-value with the user tokens
                    UserDefaults.standard.removeObject(forKey: "accessToken")
                    UserDefaults.standard.removeObject(forKey: "refreshToken")
                    print("Users logged out successfully")
                    self.loggedIn = false
                case .failure(let error):
                    switch error {
                    case Network.NetworkError.noInternet:
                        print("No internet")
                    case Network.NetworkError.clientError:
                        print("Client error")
                    case Network.NetworkError.statusNotSuccess:
                        print("No success status")
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
