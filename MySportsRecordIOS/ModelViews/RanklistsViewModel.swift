//
//  RanklistsViewModel.swift
//  MySportsRecordIOS
//
//  Created by Ásmundur Óskar Ásmundsson on 19.12.2022.
//

import Foundation

class RanklistsViewModel: ObservableObject {
    @Published var topUsers: Users = Users(users: [])
    
    func getTopUsers() {
        Network.shared.getTopUsers() { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    // Parse the data
                    let users = Parser().parseUsers(data: data)
                    // Update the model
                    self.topUsers.setUsers(users: users.users)
                case .failure(let error):
                    switch error {
                    case Network.NetworkError.noInternet:
                        print("No internet")
                    case Network.NetworkError.clientError:
                        print("Client error")
                    case Network.NetworkError.statusNotSuccess:
                        print("Not success status code")
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
