//
//  FileManager.swift
//  RollDice
//
//  Created by Can Önal on 12.11.22.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0].appendingPathComponent("savedResults")
    }
}
