//
//  ContentView.swift
//  HabitTracker
//
//  Created by Can Önal on 01.09.22.
//

import SwiftUI

struct ActivityScreen: View {
    @StateObject var activityList = ActivityList()
    
    let showDetail: (Activity, ActivityList) -> Void
    let addActivity: (ActivityList) -> Void
    
    var body: some View {
        List {
            Section(header: Text("My Habits")) {
                ForEach(activityList.activities) { activity in
                    ActivityItem(activityList: activityList, item: activity, showDetail: showDetail)
                }
                .onDelete(perform: removeItems)
            }
            .listRowBackground(Color.darkBackground)
        }
        .navigationTitle("HabitTracker")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button {
                addActivity(activityList)
            } label: {
                Image(systemName: "plus")
            }
        }
    }
    
    private func removeItems(at offsets: IndexSet) {
        activityList.activities.remove(atOffsets: offsets)
    }
}

struct ActivityScreen_Previews: PreviewProvider {
    static var previews: some View {
        ActivityScreen(showDetail: { _,_ in }, addActivity: { _ in })
    }
}
