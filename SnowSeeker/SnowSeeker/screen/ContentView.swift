//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Can Önal on 14.11.22.
//

import SwiftUI

/// force phone to use stack navigation (iPhone 13 Pro Max landscape mode for example)
///  and use this modifier for NavigationView
//extension View {
//    @ViewBuilder func phoneOnlyNavigationView() -> some View {
//        if UIDevice.current.userInterfaceIdiom == .phone {
//            self.navigationViewStyle(.stack)
//        } else {
//            self
//        }
//    }
//}

struct ContentView: View {
    @State private var searchText = ""
    @State private var isShowingSortDialog = false
    
    @StateObject var resorts = Resorts()
    @StateObject var favorites = Favorites()
    
   // let resorts: [Resort] = Bundle.main.decode("resorts.json")
    
    var body: some View {
        NavigationView {
            List(filteredResorts) { resort in
                NavigationLink {
                    ResortView(resort: resort)
                } label: {
                    HStack {
                        Image(resort.country)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 25)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                            .overlay {
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.black, lineWidth: 1)
                            }
                        
                        VStack(alignment: .leading) {
                            Text(resort.name)
                                .font(.headline)
                            Text("\(resort.runs) runs")
                                .foregroundColor(.secondary)
                        }
                        
                        if favorites.contains(resort) {
                            Spacer()
                            Image(systemName: "heart.fill")
                                .accessibilityLabel("This is a favorite resort")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
            .navigationTitle("Resorts")
            .searchable(text: $searchText, prompt: "Search for a resort")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Sort") {
                        isShowingSortDialog = true
                    }
                }
            }
            .confirmationDialog("Sort", isPresented: $isShowingSortDialog) {
                Button("By default order") {
                    resorts.sortByDefaultOrder()
                }
                
                Button("By alphabetical order") {
                    resorts.sortByAlphabeticalOrder()
                }
                
                Button("By country") {
                    resorts.sortByCountry()
                }
            }
            
            WelcomeView()
        }
        .environmentObject(favorites)
        //.phoneOnlyNavigationView()
    }
    
    var filteredResorts: [Resort] {
        if searchText.isEmpty {
            return resorts.allResorts
        } else {
            return resorts.allResorts.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
