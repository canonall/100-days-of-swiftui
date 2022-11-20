//
//  FileManager-DocumentsDirectory.swift
//  BucketList
//
//  Created by Can Önal on 09.10.22.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
