//
//  AccessibilityGrouping.swift
//  AccessibilityIntroduction
//
//  Created by Can Önal on 14.10.22.
//

import SwiftUI

struct AccessibilityDataGrouping: View {
    var body: some View {
        VStack {
            Image(decorative: "character")
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 300)
                .accessibilityHidden(true)
            
            Text("Your score is")
            Text("1000")
        }
        .accessibilityElement() // defaut value -> children: .ignore
        .accessibilityLabel("Use this label")
    }
}

struct AccessibilityDataGrouping_Previews: PreviewProvider {
    static var previews: some View {
        AccessibilityDataGrouping()
    }
}
