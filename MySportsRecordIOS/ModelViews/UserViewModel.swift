//
//  UserViewModel.swift
//  MySportsRecordIOS
//
//  Created by Ásmundur Óskar Ásmundsson on 7.1.2023.
//

import Foundation

class UserViewModel: ObservableObject {
    @Published var user: User? = nil
    
    func getUser() {
        let accessToken = UserDefaults.standard.object(forKey: "accessToken") as? String
        if accessToken == nil {
            return
        }
        Network.shared.request(method: "GET", url: "http://localhost:3001/user", body: nil, token: accessToken, type: User.self) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self.user = data
                case .failure(let error):
                    switch error {
                    case Network.NetworkError.noInternet:
                        print("No internet")
                    case Network.NetworkError.clientError:
                        print("Client error")
                    case Network.NetworkError.statusNotSuccess:
                        print("Status error")
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
