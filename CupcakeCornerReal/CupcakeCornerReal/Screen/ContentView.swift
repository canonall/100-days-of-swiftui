//
//  ContentView.swift
//  CupcakeCornerReal
//
//  Created by Can Önal on 06.09.22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var orderWrapper = OrderWrapper(order: Order())
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your cake type", selection: $orderWrapper.order.type) {
                        ForEach(Order.types.indices, id: \.self) {
                            Text(Order.types[$0])
                        }
                    }
                    
                    Stepper("Number of cakes: \(orderWrapper.order.quantity)", value: $orderWrapper.order.quantity, in: 3...20)
                }
                
                Section {
                    Toggle("Any special requests?", isOn: $orderWrapper.order.specialRequestEnabled.animation())
                    
                    if orderWrapper.order.specialRequestEnabled {
                        Toggle("Add extra frosting", isOn: $orderWrapper.order.extraFrosting)
                        Toggle("Add extra sprinkles", isOn: $orderWrapper.order.addSprinkles)
                    }
                }
                
                Section {
                    NavigationLink {
                        AddressScreen(orderWrapper: orderWrapper)
                    } label: {
                        Text("Delivery details")
                            .foregroundColor(.blue)
                    }
                }
                
                
            }
            .navigationTitle("CupcakeCorner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
