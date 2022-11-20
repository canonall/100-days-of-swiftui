//
//  GalleryItem.swift
//  PictureLabeler
//
//  Created by Can Önal on 16.10.22.
//

import SwiftUI

struct GalleryItem: View {
    
    let pictureData: PictureData
    let onItemClick: (PictureData) -> Void
    
    var body: some View {
        HStack(spacing: 18) {
            Image(uiImage: pictureData.wrappedUIImage)
                .resizable()
                .scaledToFit()
                .frame(width: 90, height: 90)
                .background(.gray)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(pictureData.label)
                    
                Text(pictureData.location.name ?? "No location detected")
                    .foregroundColor(.secondary)
                    .font(.caption)
                    .italic()
            }
            
            Spacer()
            Image(systemName: "chevron.forward")
                .font(.caption)
                .opacity(0.6)
        }
        // Makes it able to click spacer area
        .contentShape(Rectangle())
        .onTapGesture {
            onItemClick(pictureData)
        }
    }
}
