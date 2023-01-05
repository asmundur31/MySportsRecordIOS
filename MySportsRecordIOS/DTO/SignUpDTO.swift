//
//  SignUpDTO.swift
//  MySportsRecordIOS
//
//  Created by Ásmundur Óskar Ásmundsson on 5.1.2023.
//

import Foundation

struct SignUpUserDTO: Codable {
    var username: String
    var email: String
    var password: String
    var birthday: String
    var gender: String
    var nationality: String?
    var club: String?
}
