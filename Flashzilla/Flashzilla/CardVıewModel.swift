//
//  CardVıewModel.swift
//  Flashzilla
//
//  Created by Can Önal on 08.11.22.
//

import Foundation

@MainActor class CardViewModel: ObservableObject {
    @Published var cards = [Card]()
    
    func loadData() {
        do {
            let data = try Data(contentsOf: FileManager.documentsDirectory)
            cards = try JSONDecoder().decode([Card].self, from: data)
        } catch {
            print("error")
            cards = []
        }
    }
    
    func saveData() {
        do {
            let data = try JSONEncoder().encode(cards)
            try data.write(to: FileManager.documentsDirectory, options: [.atomic, .completeFileProtection])
        } catch {
            print("encoding problem")
        }
    }
}
