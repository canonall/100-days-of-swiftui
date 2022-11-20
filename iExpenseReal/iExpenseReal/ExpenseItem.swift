//
//  ExpenseItem.swift
//  iExpenseReal
//
//  Created by Can Önal on 16.08.22.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let expenseType: ExpenseType
    let currencyType: CurrencyType
    let amount: Double
}

enum ExpenseType: String ,Codable, CaseIterable {
    case Personal
    case Business
}

enum CurrencyType: String, Codable, CaseIterable {
    case USD
    case EUR
    case GBP
    case TRY
}
