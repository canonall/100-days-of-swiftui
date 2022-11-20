//
//  AddLabelViewModel.swift
//  PictureLabeler
//
//  Created by Can Önal on 15.10.22.
//

import CoreLocation
import Foundation
import SwiftUI

extension AddLabelScreen {
    @MainActor class ViewModel: ObservableObject {
        @Published var label = ""
        @Published var location: Location?
        
        var pictureDataList = [PictureData]()
        
        func setPictureDataList(pictureDataList: [PictureData]) {
            self.pictureDataList = pictureDataList
        }
        
        private func createPictureData(of uiImage: Data) -> PictureData {
            PictureData(uiImage: uiImage, label: label, location: location ?? Location(id: UUID(), latitude: 0, longitude: 0))
        }
        
        func saveToDirectory(uiImage: UIImage) {
            if let jpegData = uiImage.jpegData(compressionQuality: 0.8) {
                do {
                    let pictureData = createPictureData(of: jpegData)
                    pictureDataList.append(pictureData)
                    let data = try JSONEncoder().encode(pictureDataList)
                    try data.write(to: FileManager.documentsDirectory, options: [.atomic, .completeFileProtection])
                } catch {
                    print("encoding problem")
                }
            }
        }
    }
}
