//
//  Card.swift
//  Flashzilla
//
//  Created by Can Önal on 05.11.22.
//

import Foundation

struct Card: Codable, Identifiable {
    var id = UUID()
    let prompt: String
    let answer: String
    
    /// for preview
    static let example = Card(prompt: "Who is the GOAT?", answer: "LeBron James")
}
