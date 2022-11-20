//
//  GridLayout.swift
//  Moonshot
//
//  Created by Can Önal on 23.08.22.
//

import SwiftUI

struct GridLayout: View {
    let astonauts: [String: Astronaut]
    let missions: [Mission]
    
    let colums = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: colums) {
                ForEach(missions) { mission in
                    NavigationLink {
                        MissionView(mission: mission, astronauts: astonauts)
                    } label: {
                        MissionItem(mission: mission)
                    }
                }
            }
            .padding([.horizontal, .bottom])
        }
    }
}
