//
//  AddressScreen.swift
//  CupcakeCornerReal
//
//  Created by Can Önal on 06.09.22.
//

import Combine
import SwiftUI

struct AddressScreen: View {
    @ObservedObject var orderWrapper: OrderWrapper
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $orderWrapper.order.name)
                TextField("Street adress", text: $orderWrapper.order.streetAddress)
                TextField("City", text: $orderWrapper.order.city)
                TextField("Zip", text: $orderWrapper.order.zip)
                    .keyboardType(.numberPad)
                    .onReceive(Just(orderWrapper.order.zip)) { newValue in
                        let filtered = newValue.filter { "0123456789".contains($0)}
                        if filtered != newValue {
                            self.orderWrapper.order.zip = filtered
                        }
                    }
            }
            
            Section {
                NavigationLink {
                    CheckoutScreen(orderWrapper: orderWrapper)
                } label: {
                    Text("Check out")
                        .foregroundColor(.blue)
                }
                .disabled(!orderWrapper.order.hasValidAddress)
            }
            .navigationTitle("Delivery details")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct AddressScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddressScreen(orderWrapper: OrderWrapper(order: Order()))
        }
    }
}
