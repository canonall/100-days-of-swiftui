//
//  Expenses.swift
//  iExpenseReal
//
//  Created by Can Önal on 16.08.22.
//

import Foundation

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "items")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "items") {
            if let decodedItem = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItem
                return
            }
        }
        items = []
    }
}
