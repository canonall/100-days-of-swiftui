//
//  ContentView.swift
//  iExpenseReal
//
//  Created by Can Önal on 15.08.22.
//

import SwiftUI

struct ContentView: View {
    //@StateObject
    //when @Published property changes in Expenses reloads view.
    //Only use when creating a class instance
    //other times use @ObservedObject for existing class instance
    //Classes that are used with @StateObject must conform to the ObservableObject protocol.
    @StateObject var expenses = Expenses()
    
    @State private var isShowingAddExpense = false
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text(ExpenseType.Business.rawValue)) {
                    ForEach(expenses.items) { item in
                        if(item.expenseType == ExpenseType.Business) {
                            ListRow(item: item)
                        }
                    }
                    .onDelete(perform: removeItems)
                }
                
                Section(header: Text(ExpenseType.Personal.rawValue)) {
                    ForEach(expenses.items) { item in
                        if(item.expenseType == ExpenseType.Personal) {
                            ListRow(item: item)
                        }
                    }
                    .onDelete(perform: removeItems)
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    isShowingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $isShowingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }
    
    private func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ListRow: View {
    let item: ExpenseItem
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.headline)
                
                Text(item.expenseType.rawValue)
            }
            Spacer()
            
            Text(item.amount, format: .currency(code: item.currencyType.rawValue))
                .foregroundColor(setAmountColor(amount: item.amount))
        }
    }
    
    private func setAmountColor(amount: Double) -> Color {
        switch amount {
        case 0..<10:
            return .green
        case 10..<100:
            return .orange
        case 100...Double.greatestFiniteMagnitude:
            return .red
        default:
            fatalError()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
