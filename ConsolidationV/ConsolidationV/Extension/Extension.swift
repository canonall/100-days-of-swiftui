//
//  Extension.swift
//  ConsolidationV
//
//  Created by Can Önal on 24.09.22.
//

import Foundation

extension Date {
    func getFormattedDate(format: String) -> String {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = format
        return dateFormat.string(from: self)
    }
}
