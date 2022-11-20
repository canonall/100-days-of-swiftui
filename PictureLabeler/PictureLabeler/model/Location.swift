//
//  Location.swift
//  PictureLabeler
//
//  Created by Can Önal on 17.10.22.
//

import Foundation
import CoreLocation

struct Location: Identifiable, Codable {
    var id: UUID
    var name: String?
    let latitude: Double
    let longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    var latitudeString: String {
        String(latitude)
    }
    
    var longitudeString: String {
        String(longitude)
    }
}
