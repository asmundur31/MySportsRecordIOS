//
//  UserViewModel.swift
//  MySportsRecordIOS
//
//  Created by Ásmundur Óskar Ásmundsson on 7.1.2023.
//

import Foundation
import FirebaseStorage

class UserViewModel: ObservableObject {
    @Published var user: User? = nil
    @Published var newTrampetSkill: TrampetSkill = TrampetSkill()
    @Published var userTrampetSkills: [TrampetSkill] = []
    @Published var recentSkills: [SkillDTO] = []
    
    // Function that gets user
    func getUser() {
        let accessToken = UserDefaults.standard.object(forKey: "accessToken") as? String
        if accessToken == nil {
            return
        }
        Network.shared.request(method: "GET", url: "http://localhost:3001/user", body: nil, token: accessToken, type: User.self) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    print(data)
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
    
    // Function that adds a trampet skill to user
    func addTrampetSkill(videoData: Data) {
        let accessToken = UserDefaults.standard.object(forKey: "accessToken") as? String
        if accessToken == nil {
            return
        }
        // Save video to storage and get url
        let name = "\(Int(Date().timeIntervalSince1970)).mp4"
        let ref = Storage.storage().reference(withPath: accessToken!).child("Videos").child(name)

        ref.putData(videoData) { metadata, err in
            if let err = err {
                print("Failed to push video to storage: \(err)")
                return
            }
            ref.downloadURL { url, err in
                if let err = err {
                    print("Failed to retrive video downloadURL: \(err)")
                    return
                }
                print("Successfully stored image with url: \(url?.absoluteString ?? "")")
                self.sendNewTrampetSkill(videoUrl: url?.absoluteString ?? "", accessToken: accessToken!)
            }
        }
        
    }
    
    func sendNewTrampetSkill(videoUrl: String, accessToken: String) {
        var parsePositions: [String] = []
        for pos in newTrampetSkill.positions {
            parsePositions.append(pos.rawValue)
        }
        
        let body: [String: Any] = [
            "table": self.convertEntryElement(newTrampetSkill.entryElement),
            "saltos": newTrampetSkill.saltos.rawValue,
            "twists": newTrampetSkill.twists,
            "positions": parsePositions,
            "video_url": videoUrl
        ]
        Network.shared.request(method: "POST", url: "http://localhost:3001/user/trampet", body: body, token: accessToken, type: String.self) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    print(data)
                    self.getUser()
                    self.getUserTrampetSkills()
                case .failure(let error):
                    switch error {
                    case Network.NetworkError.noInternet:
                        print("No internet")
                    case Network.NetworkError.clientError:
                        print("Client error")
                    case Network.NetworkError.statusNotSuccess:
                        print("Status not success error")
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
    // Helper function for converting entry element before sending a skill to api
    func convertEntryElement(_ entryEl: TrampetSkill.EntryElement) -> String {
        switch entryEl {
        case TrampetSkill.EntryElement.no:
            return "No"
        case TrampetSkill.EntryElement.h:
            return "H"
        case TrampetSkill.EntryElement.h90:
            return "R"
        case TrampetSkill.EntryElement.h180:
            return "1H"
        case TrampetSkill.EntryElement.tsu:
            return "TSU"
        case TrampetSkill.EntryElement.kas:
            return "KAS"
        }
    }
    
    func getUserTrampetSkills() {
        let accessToken = UserDefaults.standard.object(forKey: "accessToken") as? String
        if accessToken == nil {
            return
        }
        Network.shared.request(method: "GET", url: "http://localhost:3001/user/trampet", body: nil, token: accessToken, type: [TrampetSkillDTO].self) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    print(data)
                    // Parse data to TrampetSkill list
                    self.userTrampetSkills = Parser().parseTrampetSkills(trampetSkills: data)
                case .failure(let error):
                    switch error {
                    case Network.NetworkError.noInternet:
                        print("No internet")
                    case Network.NetworkError.clientError:
                        print("Client error")
                    case Network.NetworkError.statusNotSuccess:
                        print("Status not success error")
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
    
    func getRecentSkills() {
        Network.shared.request(method: "GET", url: "http://localhost:3001/ranklists/recent-skills", body: nil, token: nil, type: [SkillDTO].self) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    print(data)
                    // Parse data to TrampetSkill list
                    self.recentSkills = data
                case .failure(let error):
                    switch error {
                    case Network.NetworkError.noInternet:
                        print("No internet")
                    case Network.NetworkError.clientError:
                        print("Client error")
                    case Network.NetworkError.statusNotSuccess:
                        print("Status not success error")
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
