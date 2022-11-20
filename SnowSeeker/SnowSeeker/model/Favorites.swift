//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Can Önal on 17.11.22.
//

import Foundation

class Favorites: ObservableObject {
    private var resorts: Set<String>
    private let saveKey = "favorites"
    
    init() {
        do {
            let data = try Data(contentsOf: FileManager.documentsDirectory)
            resorts = try JSONDecoder().decode(Set<String>.self, from: data)
        } catch {
            resorts = []
        }
    }
    
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }
    
    func add(_ resort: Resort) {
        objectWillChange.send()
        resorts.insert(resort.id)
        save()
    }
    
    func remove(_ resort: Resort) {
        objectWillChange.send()
        resorts.remove(resort.id)
        save()
    }
    
    func save() {
        do {
            let data = try JSONEncoder().encode(resorts)
            try data.write(to: FileManager.documentsDirectory, options: [.atomic, .completeFileProtection])
        } catch {
            print("encoding error")
        }
    }
}
