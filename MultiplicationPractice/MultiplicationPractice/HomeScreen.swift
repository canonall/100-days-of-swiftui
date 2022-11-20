//
//  HomeScreen.swift
//  MultiplicationPractice
//
//  Created by Can Önal on 13.08.22.
//

import SwiftUI

struct HomeScreen: View {
    @State private var tableCount = 2
    @State private var questionCount = 10
    
    let onGameTapped: (Int, Int) -> Void
    let minTableCount = 2
    let maxTableCount = 12
    
    var body: some View {
        NavigationView {
            Form {
                Section("Select tables up to") {
                    Stepper("\(tableCount)", value: $tableCount, in: 2...12 )
                }
                
                Section("Select question count") {
                    Picker("", selection: $questionCount) {
                        ForEach(Array(stride(from: 5, through: 50, by: 5)), id: \.self) { number in
                            Text("\(number)")
                        }
                    }
                    .pickerStyle(.wheel)
                }
                
                Section {
                    Button("Start Game", action: {
                        onGameTapped(questionCount, tableCount)
                    })
                }
            }
            .navigationTitle("Adjust your settings")
        }
    }
}


struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen(onGameTapped: { _ , _ in })
    }
}
