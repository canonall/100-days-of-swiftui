//
//  OrderDetails.swift
//  CupcakeCornerReal
//
//  Created by Can Önal on 09.09.22.
//

import SwiftUI

struct OrderDetails: View {
    
    let order: Order
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            
            Text("Order details")
                .font(.caption)
            
            Text("\(order.quantity) \(Order.types[order.type]) cupcakes")
                .font(.title2)
                
            if(order.extraFrosting) {
                Text("With extra frosting")
                    .font(.headline)
            }
            
            if(order.addSprinkles) {
                Text("With sprinkles")
                    .font(.headline)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}

struct OrderDetails_Previews: PreviewProvider {
    static var previews: some View {
        OrderDetails(order: Order())
    }
}
