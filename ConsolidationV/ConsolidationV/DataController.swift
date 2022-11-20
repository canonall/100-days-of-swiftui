//
//  DataController.swift
//  ConsolidationV
//
//  Created by Can Önal on 24.09.22.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    //refers to CachedModel.xcdatamodeld
    let container = NSPersistentContainer(name: "CachedModel")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load \(error.localizedDescription)")
                return
            }
        }
    }
}
