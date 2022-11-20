//
//  MissionView.swift
//  Moonshot
//
//  Created by Can Önal on 22.08.22.
//

import SwiftUI

struct MissionView: View {
    let mission: Mission
    let crewMembers: [CrewMember]
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width * 0.6) //60% percent of available screen width
                        .padding(.top)
                    
                    VStack(alignment: .leading) {
                        CustomDivider()
                        
                        MissionDetailTitle(title: "Mission Highlights")
                        
                        Text(mission.formattedLaunchDate)
                            .font(.headline)
                            .foregroundColor(.secondary)
                            .padding(.bottom, 5)
                        
                        Text(mission.description)
                        
                        CustomDivider()
                        
                        MissionDetailTitle(title: "Crew")
                    }
                    .padding(.horizontal)
                    
                    AstronautsRecapView(crewMembers: crewMembers)
                }
                .padding(.bottom)
            }
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
    
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission
        self.crewMembers = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Missing \(member.name)")
            }
        }
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode(file: "mission.json")
    static let astronauts: [String: Astronaut] = Bundle.main.decode(file: "astronauts.json")
    
    static var previews: some View {
        MissionView(mission: missions[0], astronauts: astronauts)
            .preferredColorScheme(.dark)
    }
}
