//
//  MapScreen.swift
//  PictureLabeler
//
//  Created by Can Önal on 17.10.22.
//

import MapKit
import SwiftUI

struct MapScreen: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel = ViewModel()
    @StateObject private var locationfetcher = LocationFetcher()
    
    @Binding var location: Location?
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $locationfetcher.region,
            showsUserLocation: true)
                .ignoresSafeArea()
            Image(systemName: "mappin")
                .padding()
                .background(.black.opacity(0.2))
                .foregroundColor(.white)
                .font(.title)
                .clipShape(Circle())
            
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    Button{
                        location = viewModel.setLocation(latitude: locationfetcher.region.center.latitude, longitude: locationfetcher.region.center.longitude)
                        setLocationName()
                        dismiss()
                    } label: {
                        Image(systemName: "checkmark")
                            .padding()
                            .background(.black.opacity(0.7))
                            .foregroundColor(.white)
                            .font(.caption)
                            .clipShape(Circle())
                            .padding(.trailing)
                    }
                }
            }
        }
    }
    func setLocationName()  {
        guard let wrappedLocation = location else { return }
        
        let geoCoder = CLGeocoder()
        let clLocation = CLLocation(latitude: wrappedLocation.latitude, longitude: wrappedLocation.longitude)
        geoCoder.reverseGeocodeLocation(clLocation, completionHandler: { placemarks, error in
            location?.name = placemarks?[0].name
        })
    }
}
