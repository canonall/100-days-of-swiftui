//
//  MissionDetailTitle.swift
//  Moonshot
//
//  Created by Can Önal on 23.08.22.
//

import SwiftUI

struct MissionDetailTitle: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(.title.bold())
            .padding(.bottom, 5)
    }
}
