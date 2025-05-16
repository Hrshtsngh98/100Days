//
//  ShuffleData.swift
//  DiceRoll
//
//  Created by Harshit Singh on 5/16/25.
//

import Foundation

class ShuffleData: Identifiable {
    var id: UUID = UUID()
    var diceValues: [Int]
    
    init(diceValues: [Int]) {
        self.diceValues = diceValues
    }
}
