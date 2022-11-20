//
//  ImageView.swift
//  ConsolidationV
//
//  Created by Can Önal on 23.09.22.
//

import SwiftUI

struct ProfileImage: View {
    
    let user: CachedUser
    var parentGeometry: GeometryProxy
    
    var body: some View {
        if(user.isActive) {
        AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                       image
                           .resizable()
                           .scaledToFit()
                           .clipShape(Circle())
                   } placeholder: {
                      Image(systemName: "person.circle.fill")
                           .resizable()
                           .scaledToFit()
                   }
                   .frame(width: parentGeometry.size.width, height: 120)
                   .padding(.top)
        } else {
            Image(systemName: "person.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: parentGeometry.size.width, height: 120)
                .padding(.top)
        }
    }
}
