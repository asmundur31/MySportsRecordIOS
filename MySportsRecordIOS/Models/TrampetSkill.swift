//
//  TrampetSkill.swift
//  MySportsRecordIOS
//
//  Created by Ásmundur Óskar Ásmundsson on 9.1.2023.
//

import Foundation

struct TrampetSkill: Hashable {
    var entryElement: EntryElement = EntryElement.no
    var saltos: Salto = Salto.zero
    var twists: [Double] = [0.0, 0.0, 0.0]
    var positions: [Position] = [Position.tucked, Position.tucked, Position.tucked]
    var videoUrl: String = ""
    var value: Double = 0.0
    
    mutating func setEntryElement(_ e: EntryElement) {
        entryElement = e
    }
    
    mutating func setSaltos(_ i: Salto) {
        saltos = i
        twists = [0.0, 0.0, 0.0]
        positions = [Position.tucked, Position.tucked, Position.tucked]
    }
    
    mutating func setTwist(index: Int, value: Double) {
        twists[index] = value
    }
    
    mutating func setPosition(index: Int, value: Position) {
        positions[index] = value
    }
}

extension TrampetSkill {
    enum Salto: Int, Identifiable, CaseIterable {
        var id: Self { self }
        case zero = 0
        case one = 1
        case two = 2
        case three = 3
    }
    enum Position: String, Identifiable, CaseIterable {
        var id: Self { self }
        case tucked = "tucked"
        case piked = "piked"
        case straight = "straight"
    }
    
    enum EntryElement: String, Identifiable, CaseIterable {
        var id: Self { self }
        case no = "No table"
        case h = "Handspring"
        case h90 = "Handspring 1/4 on 1/4 off"
        case h180 = "Handspring 1/2 on"
        case tsu = "Tsukahara"
        case kas = "Kasamatsu"
    }
}
