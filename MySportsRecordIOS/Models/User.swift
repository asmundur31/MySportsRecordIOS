//
//  User.swift
//  MySportsRecordIOS
//
//  Created by Ásmundur Óskar Ásmundsson on 7.1.2023.
//

import Foundation

struct User: Hashable, Codable {
    var username: String
    var email: String
    var birthday: String
    var gender: String
    var nationality: String?
    var club: String?
    var score: Double
}
