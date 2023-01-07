//
//  Token.swift
//  MySportsRecordIOS
//
//  Created by Ásmundur Óskar Ásmundsson on 7.1.2023.
//

import Foundation

struct TokenDTO: Codable {
    var accessToken: String
    var refreshToken: String
}
