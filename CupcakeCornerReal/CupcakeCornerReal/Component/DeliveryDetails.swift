//
//  DeliveryDetails.swift
//  CupcakeCornerReal
//
//  Created by Can Önal on 09.09.22.
//

import SwiftUI

struct DeliveryDetails: View {
    let order: Order
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            
            Text("Delivery details")
                .font(.caption)
            
            Text("\(order.name)\n\(order.streetAddress)\n\(order.city), \(order.zip)")
                .font(.body)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}

struct DeliveryDetails_Previews: PreviewProvider {
    static var previews: some View {
        DeliveryDetails(order: Order())
    }
}
