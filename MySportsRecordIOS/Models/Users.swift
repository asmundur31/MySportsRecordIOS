//
//  Users.swift
//  MySportsRecordIOS
//
//  Created by Ásmundur Óskar Ásmundsson on 19.12.2022.
//

import Foundation

struct Users: Hashable, Codable {
    private(set) var users: [User]
    
    mutating func setUsers(users: [User]) {
        self.users = users
    }
}

struct User: Hashable, Codable {
    var username: String
    var email: String
    var birthday: String
    var gender: String
    var nationality: String?
    var club: String?
    var score: Double
}
