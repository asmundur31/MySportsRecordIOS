//
//  TrampetSkillDTO.swift
//  MySportsRecordIOS
//
//  Created by Ásmundur Óskar Ásmundsson on 10.1.2023.
//

import Foundation

struct SkillDTO: Codable, Hashable {
    var skill: String
    var video_url: String
    var apparatus: String
    var value: Double
    var user: User
    
    struct User: Codable, Hashable {
        var username: String
        var email: String
        var nationality: String
        var club: String
        var birthday: String
        var gender: String
        var score: Double
    }
}
