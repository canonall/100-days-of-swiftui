//
//  AstronautsRecapView.swift
//  Moonshot
//
//  Created by Can Önal on 23.08.22.
//

import SwiftUI

struct CrewMember {
    let role: String
    let astronaut: Astronaut
}

struct AstronautsRecapView: View {
    let crewMembers: [CrewMember]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(crewMembers, id: \.role) { crewMember in
                    NavigationLink {
                        AstronautDetailView(astronaut: crewMember.astronaut)
                    } label: {
                        HorizontalInfoView(
                            imagePath: crewMember.astronaut.id,
                            infoTitle: crewMember.astronaut.name,
                            infoSubTitle: crewMember.role
                        )
                    }
                }
            }
        }
    }
}
