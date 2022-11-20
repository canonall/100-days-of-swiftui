//
//  ConsolidationVApp.swift
//  ConsolidationV
//
//  Created by Can Önal on 23.09.22.
//

import SwiftUI

@main
struct ConsolidationVApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
