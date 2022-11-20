//
//  LocationFetcher.swift
//  PictureLabeler
//
//  Created by Can Önal on 23.10.22.
//

import CoreLocation
import Foundation
import MapKit

class LocationFetcher: NSObject, CLLocationManagerDelegate, ObservableObject {
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 49.43,
            longitude: 7.75),
        span: MKCoordinateSpan(latitudeDelta: 6, longitudeDelta: 6))
    let manager = CLLocationManager()
    var lastKnownLocation: CLLocationCoordinate2D?
    
    private var hasSetRegion = false
    
    override init() {
        super.init()
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
        
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastKnownLocation = locations.first?.coordinate
        
        if !hasSetRegion {
            self.region = MKCoordinateRegion(
                center: lastKnownLocation ?? CLLocationCoordinate2D(latitude: 49.43, longitude: 7.75),
                span: MKCoordinateSpan(latitudeDelta: 6, longitudeDelta: 6)
            )
            
            hasSetRegion = true
        }
    }
}
