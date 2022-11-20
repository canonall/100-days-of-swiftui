//
//  HorizontalInfoView.swift
//  Moonshot
//
//  Created by Can Önal on 23.08.22.
//

import SwiftUI

struct HorizontalInfoView: View {
    let imagePath: String
    let infoTitle: String
    let infoSubTitle: String
    
    var body: some View {
        HStack {
            Image(imagePath)
                .resizable()
                .frame(width: 104, height: 72)
                .clipShape(Capsule())
                .overlay(
                    Capsule()
                        .strokeBorder(.white, lineWidth: 1)
                )
            
            VStack(alignment: .leading) {
                Text(infoTitle)
                    .foregroundColor(.white)
                    .font(.headline)
                
                Text(infoSubTitle)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.horizontal)
    }
}

struct HorizontalInfoView_Previews: PreviewProvider {
    static let astronauts: [String : Astronaut] = Bundle.main.decode(file: "astronauts.json")
    static let grissom = astronauts["grissom"]
    
    static var previews: some View {
        HorizontalInfoView(imagePath: grissom?.id ?? "",
                           infoTitle: grissom?.name ?? "title",
                           infoSubTitle: "role"
        )
    }
}
