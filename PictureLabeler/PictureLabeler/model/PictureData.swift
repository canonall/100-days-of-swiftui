//
//  PictureData.swift
//  PictureLabeler
//
//  Created by Can Önal on 15.10.22.
//

import Foundation
import SwiftUI

class PictureData: Identifiable, Codable, Comparable {
    enum CodingKeys: CodingKey {
        case uiImage
        case label
        case location
    }
    
    var id = UUID()
    var uiImage: Data
    var label: String
    var location: Location
    
    var wrappedUIImage: UIImage {
        UIImage(data: uiImage) ?? UIImage()
    }
    
    init(uiImage: Data, label: String, location: Location) {
        self.uiImage = uiImage
        self.label = label
        self.location = location
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        uiImage = try container.decode(Data.self, forKey: .uiImage)
        label = try container.decode(String.self, forKey: .label)
        location = try container.decode(Location.self, forKey: .location)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(uiImage, forKey: .uiImage)
        try container.encode(label, forKey: .label)
        try container.encode(location, forKey: .location)
    }
    
    static func <(lhs: PictureData, rhs: PictureData) -> Bool {
        lhs.label < rhs.label
    }
    
    static func == (lhs: PictureData, rhs: PictureData) -> Bool {
        lhs.id == rhs.id
    }

}
