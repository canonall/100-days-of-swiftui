//
//  MapView-ViewModel.swift
//  BucketList
//
//  Created by Can Önal on 09.10.22.
//

import Foundation
import LocalAuthentication
import MapKit


extension MapView {
    // MainActor is responsible from making UI updates
    // When called from a SwiftUI view, ObservableObject, @State... SwiftUI puts @MainActor for us.
    // It is always called in main actor. However, called from elsewhere it is not 100%. So, for viewmodel or
    // any other class that conforms ObservableObject we put @MainActor to be sure it is called in main actor
    // UNLESS we specify otherwise by a faulty code (:
    @MainActor class ViewModel: ObservableObject {
        @Published var mapRegion = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 49.43, longitude: 7.75),
            span: MKCoordinateSpan(latitudeDelta: 8, longitudeDelta: 8)
        )
        // private(set) -> Don't let changing property value from outside
        @Published private(set) var locations : [Location]
        @Published var selectedPlace: Location?
        @Published var isUnlocked = false
        
        @Published var alertErrorMessage = ""
        @Published var showingErrorAlert = false
        
        let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedPlaces")
        
        init() {
            do {
                let data = try Data(contentsOf: savePath)
                locations = try JSONDecoder().decode([Location].self, from: data)
            } catch {
                locations = []
            }
        }
        
        func saveToDirectory() {
            do {
                let data = try JSONEncoder().encode(locations)
                try data.write(to: savePath, options: [.atomicWrite, .completeFileProtection])
            } catch {
                print("Unable to save data")
            }
        }
        
        func addLocation() {
            let newLocation = Location(
                id: UUID(),
                name: "New location",
                description: "",
                latitude: mapRegion.center.latitude,
                longitude: mapRegion.center.longitude
            )
            locations.append(newLocation)
            saveToDirectory()
        }
        
        func updateLocation(location: Location) {
            guard let selectedPlace = selectedPlace else { return }
            
            if let index = locations.firstIndex(of: selectedPlace) {
                locations[index] = location
                saveToDirectory()
            }
        }
        
        func authenticate() {
            let context = LAContext()
            var error: NSError?
            
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                let reason = "Please authenticate yourself to unlock your places."
                
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                    if success {
                        // create background task, then use that task to jump to MainActor
                        Task { @MainActor in
                            self.isUnlocked = true
                        }
                    } else {
                        // error
                        Task { @MainActor in
                            self.alertErrorMessage = "Authentication failed. Please try again."
                            self.showingErrorAlert = true
                        }
                    }
                }
            } else {
                // no biometrics
                alertErrorMessage = "Your device doesn't support authentication with biometrics."
                showingErrorAlert = true
            }
        }
    }
}
