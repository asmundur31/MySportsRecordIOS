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
    
    func parseTrampetSkills(trampetSkills: [TrampetSkillDTO]) -> [TrampetSkill] {
        var newSkills: [TrampetSkill] = []
        for trampetS in trampetSkills {
            let skillData = Data(trampetS.skill.utf8)
            let decoder = JSONDecoder()
            do {
                let skill = try decoder.decode(Skill.self, from: skillData)
                var entryE = TrampetSkill.EntryElement.no
                switch skill.table {
                case "H":
                    entryE = TrampetSkill.EntryElement.h
                case "R":
                    entryE = TrampetSkill.EntryElement.h90
                case "1H":
                    entryE = TrampetSkill.EntryElement.h180
                case "KAS":
                    entryE = TrampetSkill.EntryElement.kas
                case "TSU":
                    entryE = TrampetSkill.EntryElement.tsu
                default:
                    break
                }
                var salt = TrampetSkill.Salto.zero
                switch skill.saltos {
                case 1:
                    salt = TrampetSkill.Salto.one
                case 2:
                    salt = TrampetSkill.Salto.two
                case 3:
                    salt = TrampetSkill.Salto.three
                default:
                    break
                }
                var posi = [TrampetSkill.Position]()
                for p in skill.positions {
                    switch p {
                    case "tucked":
                        posi.append(TrampetSkill.Position.tucked)
                    case "piked":
                        posi.append(TrampetSkill.Position.piked)
                    case "straight":
                        posi.append(TrampetSkill.Position.straight)
                    default:
                        break
                    }
                }
                
                newSkills.append(TrampetSkill(entryElement: entryE, saltos: salt, twists: skill.twists, positions: posi, videoUrl: trampetS.video_url, value: trampetS.value))

            } catch {
                print(error.localizedDescription)
            }
        }
        
        return newSkills
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
    
    struct Skill: Codable {
        var table: String
        var saltos: Int
        var twists: [Double]
        var positions: [String]
    }
}
