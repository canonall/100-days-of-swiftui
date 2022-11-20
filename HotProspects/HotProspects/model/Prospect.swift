//
//  Prospect.swift
//  HotProspects
//
//  Created by Can Önal on 27.10.22.
//

import SwiftUI

class Prospect: Identifiable, Codable {
    var id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    var date = Date()
    fileprivate(set) var isContacted = false // must only be set inside this file not elsewhere    
}

@MainActor class Prospects: ObservableObject {
    @Published private(set) var people: [Prospect]
    let saveKey = "SavedData"
    
    init() {
        do {
            let data = try Data(contentsOf: FileManager.documentsDirectory)
            people = try JSONDecoder().decode([Prospect].self, from: data)
            sortByMostRecent()
        } catch {
            people = []
        }
    }
    
    private func save() {
        do {
            if let encoded = try?  JSONEncoder().encode(people) {
                try encoded.write(to: FileManager.documentsDirectory, options: [.atomic, .completeFileProtection])
            }
        } catch {
            print("encoding problem")
        }
    }
    
    func sortByName() {
       people.sort {
            $0.name < $1.name
        }
    }
    
    func sortByMostRecent() {
        people.sort {
            $0.date > $1.date
        }
    }
    
    func add(prospect: Prospect) {
        people.append(prospect)
        sortByMostRecent()
        save()
    }
    
    func toggle(_ prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
        save()
    }
}
