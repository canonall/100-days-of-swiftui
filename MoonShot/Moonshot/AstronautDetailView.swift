//
//  AstronautDetailView.swift
//  Moonshot
//
//  Created by Can Önal on 22.08.22.
//

import SwiftUI

struct AstronautDetailView: View {
    let astronaut: Astronaut
    
    var body: some View {
        ScrollView {
            VStack {
                Image(astronaut.id)
                    .resizable()
                    .scaledToFit()
                
                Text(astronaut.description)
                    .padding()
            }
        }
        .background(.darkBackground)
        .navigationTitle(astronaut.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AstronautDetailView_Previews: PreviewProvider {
    static let astronaut: [String: Astronaut] = Bundle.main.decode(file: "astronaut.json")
    
    static var previews: some View {
        AstronautDetailView(astronaut: astronaut["armstrong"]!)
    }
}
