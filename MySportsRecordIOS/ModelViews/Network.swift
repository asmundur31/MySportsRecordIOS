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
    func request<T: Codable>(method: String, url: String, body: [String: Any], type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
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
        guard let url = URL(string: url) else {
            completion(.failure(NetworkError.urlError))
            return
        }
        // Create the request
        var request = URLRequest(url: url)
        request.httpMethod = method
        if method == "POST" {
            let jsonBody = try? JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
            request.httpBody = jsonBody
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        // Create the task
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
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
                if method == "GET" {
                    if let result = try? JSONDecoder().decode(T.self, from: data) {
                        completion(.success(result))
                    } else {
                        completion(.failure(NetworkError.decodeError))
                    }
                }
            }
            // If post method it was successful
            if method == "POST" {
                completion(.success("Successful" as! T))
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
