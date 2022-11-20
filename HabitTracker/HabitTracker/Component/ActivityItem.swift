//
//  ActivityItem.swift
//  HabitTracker
//
//  Created by Can Önal on 02.09.22.
//

import SwiftUI

struct ActivityItem: View {
    
    @ObservedObject var activityList: ActivityList
    
    let item: Activity
    let showDetail: (Activity, ActivityList) -> Void
    
    var body: some View {
        Button(action: { showDetail(item, activityList) }) {
            HStack {
                VStack{
                    VStack(alignment: .leading) {
                        if(item.hasDescription) {
                            Text(item.title)
                                .font(.title2)
                                .padding(.bottom, 2)
                            
                            Text(item.description)
                                .font(.callout)
                                .foregroundColor(.secondary)
                                .padding(.bottom, 1)
                        } else {
                            Text(item.title)
                                .font(.title2)
                                .padding(.bottom, 2)
                        }
                        
                        Text("Completed \(item.completionCount) times")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                Image(systemName: "chevron.right")
                    .font(.system(.caption))
            }
            .padding(.vertical, 8)
        }
        .buttonStyle(.plain)
    }
}

struct ActivityItem_Previews: PreviewProvider {
    static let activity = Activity(title: "Habit Title", description: "Habit description",  hasDescription: true,completionCount: 3)
    static let activityList = ActivityList()
    static var previews: some View {
        ActivityItem(activityList: activityList, item: activity, showDetail: { _,_ in })
    }
}
