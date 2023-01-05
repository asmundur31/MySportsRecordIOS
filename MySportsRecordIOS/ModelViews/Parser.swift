//
//  Parser.swift
//  MySportsRecordIOS
//
//  Created by Ásmundur Óskar Ásmundsson on 19.12.2022.
//

import Foundation

// Class that handles the parsing of the data
class Parser {
    
    // Function that parses the incomming data and returns a forcast as our model
    func parseUsers(data: [UserDTO]) -> Users {
        var newUsers: [User] = []
        for u in data {
            newUsers.append(User(username: u.username, email: u.email, birthday: u.birthday, gender: u.gender, nationality: u.nationality, club: u.club, score: u.score))
        }
        
        return Users(users: newUsers)
    }
    
    // Function to prettify the date
    func prettyDate(_ dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: dateString)!
        let prettyDateFormatter = DateFormatter()
        prettyDateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        return prettyDateFormatter.string(from: date)
    }
}
