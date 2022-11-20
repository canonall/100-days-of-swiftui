//
//  FileManager.swift
//  PictureLabeler
//
//  Created by Can Önal on 15.10.22.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0].appendingPathComponent("SavedPictureData")
    }
}
