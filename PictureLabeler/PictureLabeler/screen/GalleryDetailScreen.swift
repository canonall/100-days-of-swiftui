//
//  GalleryDetailScreen.swift
//  PictureLabeler
//
//  Created by Can Önal on 15.10.22.
//

import SwiftUI

struct GalleryDetailScreen: View {
    let pictureData: PictureData
    var image: Image
    
    init(pictureData: PictureData) {
        self.pictureData = pictureData
        self.image = Image(uiImage: pictureData.wrappedUIImage)
    }
    
    var body: some View {
            VStack{
                image
                    .resizable()
                    .scaledToFit()
                    .padding(10)
                
                Text(pictureData.label)
                    .font(.title2)
                    .padding(.bottom)
                
                Text(pictureData.location.name ?? "No location found for this picture")
                    .foregroundColor(.secondary)
                    .italic()
            }
            .navigationTitle("PictureLabeler")
            .navigationBarTitleDisplayMode(.inline)
    }
}
