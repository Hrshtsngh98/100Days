//
//  Card.swift
//  Flashzilla
//
//  Created by Harshit Singh on 5/7/25.
//

import Foundation

struct Card: Codable {
    var prompt: String
    var answer: String
    
    static let example = Card(prompt: "Who played the 13th Doctor in Doctor Who?", answer: "Jodie Whittaker")
}
