//
//  User.swift
//  ConsolidationV
//
//  Created by Can Önal on 23.09.22.
//

import Foundation

struct User: Codable, Hashable {
    var id: String
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: Date
    var tags: [String]
    var friends: [Friend]
}
