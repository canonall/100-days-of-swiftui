//
//  CheckoutScreen.swift
//  CupcakeCornerReal
//
//  Created by Can Önal on 06.09.22.
//

import SwiftUI

struct CheckoutScreen: View {    
    @ObservedObject var orderWrapper: OrderWrapper
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                
                Text("Your total is \(orderWrapper.order.cost, format: .currency(code: "EUR"))")
                    .font(.title)
                
                OrderDetails(order: orderWrapper.order)
                
                DeliveryDetails(order: orderWrapper.order)
                
                Button("Place order") {
                    Task {
                        await placeOrder()
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .alert(alertTitle, isPresented: $showingAlert) {
            Button("OK") {}
        } message: {
            Text(alertMessage)
        }
    }
    
   private func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(orderWrapper.order) else {
            print("Failed to encode order")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            
            setError(title: "Thank you!", message: "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!")
        } catch {
            setError(title: "Sorry!", message: "Checkout failed. Please try again later.")
            print("Checkout failed.")
        }
    }
    
    private func setError(title: String, message: String) {
        alertTitle = title
        alertMessage = message
        showingAlert = true
    }
}

struct CheckoutScreen_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutScreen(orderWrapper: OrderWrapper(order: Order()))
    }
}
