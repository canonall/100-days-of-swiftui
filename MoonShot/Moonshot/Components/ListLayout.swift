//
//  ListLayout.swift
//  Moonshot
//
//  Created by Can Önal on 23.08.22.
//

import SwiftUI

struct ListLayout: View {
    let astonauts: [String: Astronaut]
    let missions: [Mission]
    
    var body: some View {
        List {
            ForEach(missions) { mission in
                NavigationLink {
                    MissionView(mission: mission, astronauts: astonauts)
                } label: {
                    HStack(spacing: 18) {
                        Image(mission.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text(mission.displayName)
                                .font(.headline)
                                
                            
                            Text(mission.formattedLaunchDate)
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding(.vertical, 8)
                }
            }
            .listRowBackground(Color.darkBackground)
        }
        .listStyle(.plain)
    }
}
