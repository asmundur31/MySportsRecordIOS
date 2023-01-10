//
//  TrampetSkillDTO.swift
//  MySportsRecordIOS
//
//  Created by Ásmundur Óskar Ásmundsson on 10.1.2023.
//

import Foundation

struct TrampetSkillDTO: Codable, Hashable {
    var skill: String
    var video_url: String
    var apparatus: String
    var value: Double
}
