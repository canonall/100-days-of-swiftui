//
//  Map2.swift
//  BucketList
//
//  Created by Can Önal on 06.10.22.
//

import MapKit
import SwiftUI

struct MapView: View {
    @StateObject private var viewModel = ViewModel()
    var body: some View {
        if viewModel.isUnlocked {
            ZStack {
                Map(coordinateRegion: $viewModel.mapRegion, annotationItems: viewModel.locations) { location in
                    //                MapMarker(coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)) --> MapMarker is plain boring marker whereas MapAnnotation is custom SwiftUI view
                    MapAnnotation(coordinate: location.coordinate) {
                        VStack {
                            Image(systemName: "star.circle")
                                .resizable()
                                .foregroundColor(.red)
                                .frame(width: 44, height: 44)
                                .background(.white)
                                .clipShape(Circle())
                            
                            Text(location.name)
                                .fixedSize()
                        }
                        .onTapGesture {
                            viewModel.selectedPlace = location
                        }
                    }
                }
                .ignoresSafeArea()
                
                Circle()
                    .fill(.blue)
                    .opacity(0.3)
                    .frame(width: 32, height: 32)
                
                VStack {
                    Spacer()
                    
                    HStack {
                        Spacer()
                        
                        Button {
                            viewModel.addLocation()
                        } label: {
                            Image(systemName: "plus")
                                .padding()
                                .background(.black.opacity(0.75))
                                .foregroundColor(.white)
                                .font(.title)
                                .clipShape(Circle())
                                .padding(.trailing)
                        }
                    }
                }
            }
            // when selectedPlace is filled, sheet will open
            // unwraps optional automaticaly
            // when the sheet is dismissed, it will be nil again
            .sheet(item: $viewModel.selectedPlace) { place in
                EditView(location: place) { newLocation in
                    viewModel.updateLocation(location: newLocation)
                }
            }
        } else {
            Button("Unlock Places") {
                viewModel.authenticate()
            }
            .padding()
            .background(.blue)
            .foregroundColor(.white)
            .clipShape(Capsule())
            .alert("Error", isPresented: $viewModel.showingErrorAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(viewModel.alertErrorMessage)
            }
        }
    }
}

struct MapViewPreview: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
