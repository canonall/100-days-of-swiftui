//
//  ContentView.swift
//  UnitConverter
//
//  Created by Can Önal on 23.07.22.
//

import SwiftUI

enum UnitType: String, Hashable, CaseIterable {
    case millimeter = "mm"
    case centimeter = "cm"
    case meter = "m"
    case kilometer = "km"
    case inch = "in"
    case foot = "ft"
    case yard = "yd"
    case mile = "mi"
    
    var getMultiplier : Double {
        switch self {
        case .millimeter:
            return 1.0
        case .centimeter:
            return 0.1
        case .meter:
            return 0.001
        case .kilometer:
            return 0.000001
        case .inch:
            return 0.03937
        case .foot:
            return 0.003281
        case .yard:
           return  0.0010936
        case .mile:
            return 0.0000006214
        }
    }
}

struct ContentView: View {
    @State private var inputUnit: UnitType = .kilometer
    @State private var outputUnit: UnitType = .meter
    @State private var inputValue: Double = 1
    @FocusState private var isInputFocused: Bool
    
    var outputValue: Double {
        let inputMultiplier = inputUnit.getMultiplier
        let inputAsMillimeter = inputValue / inputMultiplier
        let outputMultiplier = outputUnit.getMultiplier
        
        return inputAsMillimeter * outputMultiplier
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Value", value: $inputValue, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($isInputFocused)
                } header: {
                    Text("Value")
                }
                
                Section {
                    Picker("Convert from", selection: $inputUnit) {
                        ForEach(UnitType.allCases, id: \.self) { unit in
                            Text(unit.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Convert from")
                }
                
                Section {
                    Picker("Convert to", selection: $outputUnit){
                        ForEach(UnitType.allCases, id: \.self) { unit in
                            Text(unit.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Convert to")
                }
                
                Section {
                    Text(outputValue.formatted())
                } header: {
                    Text("Result")
                }
            }
            .navigationTitle("UnitConverter")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done"){
                        isInputFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
