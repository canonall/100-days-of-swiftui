//
//  DataController.swift
//  CoreDataProject
//
//  Created by Can Önal on 18.09.22.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    //refers to CoreDataProject.xcdatamodeld
    let container = NSPersistentContainer(name: "CoreDataProject")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load \(error.localizedDescription)")
                return
            }
            
            self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        }
    }
}
