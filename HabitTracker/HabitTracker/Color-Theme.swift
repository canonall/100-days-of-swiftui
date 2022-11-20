//
//  Color-Theme.swift
//  HabitTracker
//
//  Created by Can Önal on 04.09.22.
//

import Foundation
import SwiftUI

//only when we extend Color
extension ShapeStyle where Self == Color {
    static var darkBackground: Color {
        Color(red: 0.1, green: 0.1, blue: 0.2)
    }
}

