//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Can Önal on 18.09.22.
//


// \.self ---> for each object there is a hash value calculated
// so it identifies the different object, each object is has different hash value
// when app is stoped and started again, for the same object, different
//hash values might be produced.

// if each property conforms Hashable protocol, then struct as whole conforms Hashable
// out of the box ( kendiliginden, ekstra birsey gerekmeden)

import CoreData
import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    //    @FetchRequest(sortDescriptors: []) var wizards: FetchedResults<Wizard>
    
    
    //I only want to see ships that belongs to star wars universe --> use predicate in @FetchReqeust
    //    @FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "universe == %@", "Star Wars")) var ships: FetchedResults<Ship>
    
    
    @State private var lastNameFilter = "A"
    
    //@FetchRequest(sortDescriptors: []) var countries: FetchedResults<Country>
    
    var body: some View {
        //        VStack {
        //            List(wizards, id: \.self) { wizard in
        //                Text(wizard.name ?? "Unknown")
        //            }
        //
        //            Button("Add") {
        //                let wizard = Wizard(context: moc)
        //                wizard.name = "Can"
        //            }
        //
        //            Button("Save") {
        //                do {
        //                    try moc.save()
        //                } catch {
        //                    print(error.localizedDescription)
        //                }
        //            }
        //        }
        //----------------------------------------------
        //        VStack {
        //            List(ships, id: \.self) { ship in
        //                Text(ship.name ?? "Unknown name")
        //            }
        //
        //            Button("Add Examples") {
        //                let ship1 = Ship(context: moc)
        //                ship1.name = "Enterprise"
        //                ship1.universe = "Star Trek"
        //
        //                let ship2 = Ship(context: moc)
        //                ship2.name = "Defiant"
        //                ship2.universe = "Star Trek"
        //
        //                let ship3 = Ship(context: moc)
        //                ship3.name = "Millenium Falcon"
        //                ship3.universe = "Star Wars"
        //
        //                let ship4 = Ship(context: moc)
        //                ship4.name = "Executor"
        //                ship4.universe = "Star Wars"
        //
        //                try? moc.save()
        //            }
        //        }
        //----------------------------------------------
        VStack {
            
            FilteredList(
                sortDescriptors: [
                    SortDescriptor(\Singer.firstName, order: .reverse),
                    SortDescriptor(\Singer.lastName)
                ],
                predicateType: .beginswith,
                filterKey: "lastName",
                filterValue: lastNameFilter
            ) { (singer: Singer) in
                    Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
                }
            
            Button("Add Examples") {
                let taylor = Singer(context: moc)
                taylor.firstName = "Taylor"
                taylor.lastName = "Swift"
                
                let ed = Singer(context: moc)
                ed.firstName = "Ed"
                ed.lastName = "Sheeran"
                
                let adele = Singer(context: moc)
                adele.firstName = "Adele"
                adele.lastName = "Adkins"
                
                try? moc.save()
            }
            
            Button("Show A") {
                lastNameFilter = "A"
            }
            
            Button("Show S") {
                lastNameFilter = "S"
            }
        }
        //----------------------------------------------
        //        VStack {
        //            List {
        //                ForEach(countries, id: \.self) { country in
        //                    Section(country.wrappedFullName) {
        //                        ForEach(country.candyArray, id: \.self) { candy in
        //                            Text(candy.wrappedName)
        //                        }
        //                    }
        //                }
        //            }
        //
        //            Button("Add Examples") {
        //                let candy1 = Candy(context: moc)
        //                candy1.name = "Mars"
        //                candy1.origin = Country(context: moc)
        //                candy1.origin?.shortName = "UK"
        //                candy1.origin?.fullName = "United Kingdom"
        //
        //                let candy2 = Candy(context: moc)
        //                candy2.name = "Kitkat"
        //                candy2.origin = Country(context: moc)
        //                candy2.origin?.shortName = "UK"
        //                candy2.origin?.fullName = "United Kingdom"
        //
        //                let candy3 = Candy(context: moc)
        //                candy3.name = "Twix"
        //                candy3.origin = Country(context: moc)
        //                candy3.origin?.shortName = "UK"
        //                candy3.origin?.fullName = "United Kingdom"
        //
        //                let candy4 = Candy(context: moc)
        //                candy4.name = "Tablerone"
        //                candy4.origin = Country(context: moc)
        //                candy4.origin?.shortName = "CH"
        //                candy4.origin?.fullName = "Switzerland"
        //
        //                try? moc.save()
        //            }
        //        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
