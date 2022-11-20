//
//  AppCoordinator.swift
//  HabitTracker
//
//  Created by Can Önal on 02.09.22.
//

import SwiftUI
import FlowStacks

struct AppCoordinator: View {
    
    enum Screen {
        case activity
        case addActivity(ActivityList)
        case activityDetail(ActivityList, Activity)
    }
    
    @State private var routes: Routes<Screen> = [.root(.activity, embedInNavigationView: true)]
    
    var body: some View {
        Router($routes) { screen, _ in
            switch(screen) {
            case .activity:
                ActivityScreen(showDetail: showDetail, addActivity: addActivity)
            case .addActivity(let activityList):
                AddActivityScreen(activityList: activityList)
            case .activityDetail(let activityList, let data):
                ActivityDetailScreen(activityList: activityList, item: data, goBackToRoot: goBackToRoot)
            }
        }
        .preferredColorScheme(.dark)
    }
    
    private func showDetail(data: Activity, activityList: ActivityList) {
        routes.push(.activityDetail(activityList, data))
    }
    
    private func addActivity(activityList: ActivityList) {
        routes.presentSheet(.addActivity(activityList))
    }
    
    private func goBackToRoot() {
      routes.goBackToRoot()
    }
}
