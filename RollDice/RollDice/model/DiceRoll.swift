//
//  Dice.swift
//  RollDice
//
//  Created by Can Önal on 12.11.22.
//

import Foundation

struct DiceRoll: Codable, Identifiable {
    var id = UUID()
    var results: [Int]
    var resultSum: Int
}
