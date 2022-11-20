//
//  WeSplitView.swift
//  WeSplit
//
//  Created by Can Önal on 20.07.22.
//

import SwiftUI

struct WeSplitView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 10
    @FocusState private var amountIsFocused: Bool
    
    var  grandTotal: Double {
        let tipSelection = Double(tipPercentage)
        
        let tipValue =  checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        
        return grandTotal
    }
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        
        return grandTotal / peopleCount
    }
    
    let currencyFormat: FloatingPointFormatStyle<Double>.Currency = .currency(code: Locale.current.currencyCode ?? "EUR")
    
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField(
                        "Amount",
                        value: $checkAmount,
                        format: currencyFormat)
                    .keyboardType(.decimalPad)
                    .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople){
                        ForEach(2..<100) { number in
                            Text("\(number) people")
                        }
                    }
                }
                
                Section {
                    Picker("Tip percentage", selection: $tipPercentage){
                        ForEach(0..<101){ tip in
                            Text(tip, format: .percent)
                                .foregroundColor(tip == 0 ? .red : .secondary)
                        }
                    }
                    .pickerStyle(.automatic)
                } header: {
                    Text("How much tip  do you want to leave?")
                }
                
                Section {
                    Text (grandTotal, format: currencyFormat)
                        .foregroundColor(tipPercentage == 0 ? .red : .primary)
                } header: {
                    Text("Total amount")
                }
                
                Section {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currencyCode ?? "EUR"))
                } header: {
                    Text("Amount per person")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                // placement: will be visible only with keyboard
                ToolbarItemGroup(placement: .keyboard) {
                    //spacer pushes Button to the right side
                    //without it, the button will be in the middle
                    Spacer()
                    
                    Button("Done"){
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct WeSplitView_Previews: PreviewProvider {
    static var previews: some View {
        WeSplitView()
    }
}
