//
//  CoreDataProjectApp.swift
//  CoreDataProject
//
//  Created by Can Önal on 18.09.22.
//

import SwiftUI

@main
struct CoreDataProjectApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
