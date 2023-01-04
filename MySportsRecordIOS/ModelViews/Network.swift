//
//  Network.swift
//  MySportsRecordIOS
//
//  Created by Ásmundur Óskar Ásmundsson on 19.12.2022.
//

import Foundation
import Network

/*
 Class that makes the API requests and converts the data to the model
 */
class Network {
    // Lets make this class a singleton
    static let shared = Network()
    private init() {}

    // Function that gets weather forcast based on location
    func getTopUsers(completion: @escaping (Result<[UserDTO], Error>) -> Void) {
        // Check the internet connection
        let monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { path in
            if path.status != .satisfied {
                // if no internet we return a failure
                completion(.failure(NetworkError.noInternet))
                return
            }
        }

        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
        
        // Create the url
        guard let url = URL(string: "http://localhost:3001/ranklists/top-users") else {
            completion(.failure(NetworkError.urlError))
            return
        }

        // Create the task
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(NetworkError.clientError(error: error)))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                let statusCode = (response as! HTTPURLResponse).statusCode
                completion(.failure(NetworkError.statusNotSuccess(status: statusCode)))
                return
            }
            if let mimeType = httpResponse.mimeType, mimeType == "application/json", let data = data {
                if let result = try? JSONDecoder().decode([UserDTO].self, from: data) {
                    completion(.success(result))
                } else {
                    completion(.failure(NetworkError.decodeError))
                }
            }
        }
        // Start the task
        task.resume()
    }
}

// Extension to the Network to handle different errors
extension Network {
    enum NetworkError: Error {
        case noInternet
        case nilInput
        case urlError
        case clientError(error: Error)
        case statusNotSuccess(status: Int)
        case decodeError
    }
}

// Structs to recive data
struct UserDTO: Codable {
    var username: String
    var score: Double
}
