//
//  Color-Theme.swift
//  Moonshot
//
//  Created by Can Önal on 21.08.22.
//

import Foundation
import SwiftUI

//only when we extend Color
extension ShapeStyle where Self == Color {
    static var darkBackground: Color {
        Color(red: 0.1, green: 0.1, blue: 0.2)
    }
    
    static var lightBackground: Color {
        Color(red: 0.2, green: 0.2, blue: 0.3)
    }
}
