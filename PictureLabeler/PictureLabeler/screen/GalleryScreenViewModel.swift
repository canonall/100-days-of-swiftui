//
//  GalleryScreenViewModel.swift
//  PictureLabeler
//
//  Created by Can Önal on 15.10.22.
//

import Foundation
import SwiftUI

extension GalleryScreen {
    @MainActor class ViewModel: ObservableObject {
        @Published var image: Image?
        @Published var inputImage: UIImage?
        @Published var pictureDataList = [PictureData]()
        
        func setData() {
            do {
                let data = try Data(contentsOf: FileManager.documentsDirectory)
                pictureDataList = try JSONDecoder().decode([PictureData].self, from: data).sorted()
            } catch {
                pictureDataList = []
            }
        }
        
        func loadImage() {
            guard let inputImage = inputImage else { return }
            image = Image(uiImage: inputImage)
        }
        
        func removeItems(at offets: IndexSet) {
            do {
                pictureDataList.remove(atOffsets: offets)
                let data = try JSONEncoder().encode(pictureDataList)
                try data.write(to: FileManager.documentsDirectory, options: [.atomic, .completeFileProtection])
            } catch {
                
            }
        }
    }
}
