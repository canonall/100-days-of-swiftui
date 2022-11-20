//
//  FileManager.swift
//  SnowSeeker
//
//  Created by Can Önal on 18.11.22.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0].appendingPathComponent("favorites")
    }
}
