//
//  Resort.swift
//  SnowSeeker
//
//  Created by Can Önal on 15.11.22.
//

import Foundation

struct Resort: Codable, Identifiable {    
    let id:String
    let name: String
    let country: String
    let description: String
    let imageCredit: String
    let price: Int
    let size: Int
    let snowDepth: Int
    let elevation: Int
    let runs: Int
    let facilities: [String]
    
    var facilityTypes: [Facility] {
        facilities.map(Facility.init)
    }
    
    static let allResorts: [Resort] = Bundle.main.decode("resorts.json")
    static let example = allResorts[0]
}

class Resorts: ObservableObject {
    var allResorts: [Resort] = Bundle.main.decode("resorts.json")
   
    func sortByDefaultOrder() {
        objectWillChange.send()
        allResorts = Bundle.main.decode("resorts.json")
    }
    
    func sortByAlphabeticalOrder() {
        objectWillChange.send()
        allResorts.sort {
            $0.name < $1.name
        }
    }
    
    func sortByCountry() {
        objectWillChange.send()
        allResorts.sort {
            $0.country < $1.country
        }
    }
}
