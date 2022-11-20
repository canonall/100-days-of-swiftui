//
//  AddView.swift
//  iExpenseReal
//
//  Created by Can Önal on 16.08.22.
//

import SwiftUI

struct AddView: View {
    //because of @ObservedObject, AddView() needs Expenses parameter when called
    @ObservedObject var expenses: Expenses
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var expenseType = ExpenseType.Business
    @State private var currencyType = UserDefaults.standard.string(forKey: "currencyType") ?? CurrencyType.EUR.rawValue
    @State private var amount = 0.0
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var isAlertShowing = false
    
    let types = ExpenseType.allCases
    let currencies = CurrencyType.allCases.map { $0.rawValue}
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                
                Picker("Type", selection: $expenseType) {
                    ForEach(types, id: \.self) {
                        Text($0.rawValue)
                    }
                }
                .pickerStyle(.inline)
                
                Section("Amount") {
                    TextField("Amount", value: $amount, format: .currency(code: currencyType))
                        .keyboardType(.decimalPad)
                        .id(currencyType)
                        .alert(errorTitle,isPresented: $isAlertShowing) {
                            Button("OK", role: .cancel) { }
                        } message: {
                            Text(errorMessage)
                        }
                }
            }
            .navigationTitle("Add new expense")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        checkAmount()
                    }
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Picker("Currency", selection: $currencyType) {
                        ForEach(currencies, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.automatic)
                    .onChange(of: currencyType) { newValue in
                        UserDefaults.standard.set(newValue, forKey: "currencyType")
                    }
                }
            }
        }
    }
    
    private func checkAmount() {
        guard amount != 0 else {
            setError(title: "Incorrect amount", message: "Amount can not be 0!")
            return
        }
        
        guard name != "" else {
            setError(title: "Incorrect name", message: "Name can not be empty!")
            return
        }
        saveAmount()
    }
    
    private func saveAmount() {
        let item  = ExpenseItem (
            name: name,
            expenseType: expenseType,
            currencyType: CurrencyType(rawValue: currencyType) ?? CurrencyType.EUR,
            amount: amount
        )
        expenses.items.append(item)
        dismiss()
    }
    
    private func setError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        isAlertShowing = true
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
