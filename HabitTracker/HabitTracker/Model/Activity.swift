//
//  Activity.swift
//  HabitTracker
//
//  Created by Can Önal on 02.09.22.
//

import Foundation

struct Activity: Codable, Equatable ,Identifiable {
    var id = UUID()
    let title: String
    let description: String
    let hasDescription: Bool
    var completionCount: Int
}
