//
//  EditView-ViewModel.swift
//  BucketList
//
//  Created by Can Önal on 12.10.22.
//

import Foundation

extension EditView {
    @MainActor class ViewModel: ObservableObject {
        
        @Published var name: String = ""
        @Published var description: String = ""
        @Published var loadingState = LoadingState.loading
        @Published var pages = [Page]()
        
        
        func setInfo(name: String, description: String) {
            self.name = name
            self.description = description
        }
        
        func createNewLocation(location: Location) -> Location {
            var newLocation = location
            // if we don't give new UUID, SwiftUI will not show the new name
            // because we tell to check id only with Equatable function. Without
            // ==() function it would work without setting new UUID()
            newLocation.id = UUID()
            newLocation.name = name
            newLocation.description = description
            
            return newLocation
        }
        
        func fetchNearByPlaces(location: Location) async {
            let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(location.coordinate.latitude)%7C\(location.coordinate.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"
            
            guard let url = URL(string: urlString) else {
                print("Bad URL: \(urlString)")
                return
            }
            
            do {
                let (data, _ ) = try await URLSession.shared.data(from: url)
                let items = try JSONDecoder().decode(Result.self, from: data)
                pages = items.query.pages.values.sorted()
                loadingState = .loaded
            } catch {
                loadingState = .failed
            }
        }
    }
}
