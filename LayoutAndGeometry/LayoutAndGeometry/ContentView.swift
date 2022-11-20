//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Can Önal on 09.11.22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
            GeometryReader { fullView in
                ScrollView(.vertical) {
                    ForEach(0..<50) { index in
                        GeometryReader { geo in
                            let maxY = geo.frame(in: .global).maxY
                            let opacity = maxY / 200
                            let customWidth = maxY / 2
                            let hue = maxY / 1000
                            Text("Row #\(index)")
                                .font(.title)
                                .frame(width: customWidth, height: 50 ,alignment: .center)
                                .background(Color(hue: hue, saturation: 0.7, brightness: 1))
                                .rotation3DEffect(.degrees(geo.frame(in: .global).minY - fullView.size.height / 2) / 5, axis: (x: 0, y: 1, z: 0))
                                .opacity(opacity)
                                .position(x: fullView.frame(in: .global).midX, y: fullView.frame(in: .global).minY)
                        }
                        .frame(height: 40)
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
