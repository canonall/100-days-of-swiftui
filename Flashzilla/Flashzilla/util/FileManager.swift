//
//  FileManager.swift
//  Flashzilla
//
//  Created by Can Önal on 08.11.22.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0].appendingPathComponent("savedQuestion")
    }
}
