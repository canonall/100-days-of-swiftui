//
//  MapViewModel.swift
//  PictureLabeler
//
//  Created by Can Önal on 17.10.22.
//

import Foundation
import MapKit

extension MapScreen {
    @MainActor class ViewModel: ObservableObject {
        func setLocation(latitude: Double, longitude: Double) -> Location {
            Location(
                id: UUID(),
                latitude: latitude,
                longitude: longitude
            )
        }
    }
}
