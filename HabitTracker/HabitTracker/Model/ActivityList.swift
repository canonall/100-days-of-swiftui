//
//  ActivityList.swift
//  HabitTracker
//
//  Created by Can Önal on 02.09.22.
//

import Foundation

class ActivityList: ObservableObject {
    @Published var activities = [Activity]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(activities) {
                UserDefaults.standard.set(encoded, forKey: "activity")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "activity") {
          if let decoded = try? JSONDecoder().decode([Activity].self, from: savedItems) {
                activities = decoded
              return
            }
        }
        activities = []
    }
}
