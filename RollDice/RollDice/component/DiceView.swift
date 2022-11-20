//
//  DiceView.swift
//  RollDice
//
//  Created by Can Önal on 12.11.22.
//

import SwiftUI

struct DiceView: View {
    let diceResult: Int?
    
    var body: some View {
        Rectangle()
            .foregroundColor(.white)
            .frame(width: 100, height: 100)
            .cornerRadius(20)
            .overlay {
                if let result = diceResult {
                    Text("\(result)")
                        .font(.largeTitle)
                        .foregroundColor(.black)
                        
                }
            }
    }
}

struct DiceView_Previews: PreviewProvider {
    static var previews: some View {
        DiceView(diceResult: 4)
    }
}
