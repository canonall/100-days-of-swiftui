//
//  ContentView.swift
//  Moonshot
//
//  Created by Can Önal on 21.08.22.
//

import SwiftUI

struct ContentView: View {
    @State private var showingGrid = false
    var currentViewType: ViewType {
        if !showingGrid { return ViewType.Grid }
        else { return ViewType.List }
    }
    let astonauts: [String: Astronaut] = Bundle.main.decode(file: "astronauts.json")
    let missions: [Mission] = Bundle.main.decode(file: "missions.json")
    
    var body: some View {
        NavigationView {
            Group {
                if showingGrid {
                    GridLayout(astonauts: astonauts, missions: missions)
                } else {
                    ListLayout(astonauts: astonauts, missions: missions)
                }
            }
            .navigationTitle("Moonshot")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button("Show as \(currentViewType.rawValue)") {
                        showingGrid.toggle()
                    }
                }
            }
            .preferredColorScheme(.dark)
            .background(.darkBackground)
        }
    }
}

enum ViewType: String {
    case Grid
    case List
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
