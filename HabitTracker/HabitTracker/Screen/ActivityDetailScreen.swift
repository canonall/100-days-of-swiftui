//
//  ActivityDetail.swift
//  HabitTracker
//
//  Created by Can Önal on 02.09.22.
//

import SwiftUI

struct ActivityDetailScreen: View {
    @ObservedObject var activityList: ActivityList
    
    @State private var showingAlert = false
    
    let item: Activity
    let goBackToRoot: () -> Void
    
    var body: some View {
        GeometryReader { geometry in
            ZStack{
                VStack(alignment: .leading, spacing: 10) {
                    Text(item.title)
                        .font(.title)
                        .padding()
                    
                    if(item.hasDescription){
                        Text(item.description)
                            .font(.body)
                            .foregroundColor(.secondary)
                            .padding(.horizontal)
                    }
                    
                    HStack {
                        Text("Completed \(item.completionCount) times")
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .padding()
                        
                        Spacer()
                        
                        Button(action: increaseCompletionCount, label: {
                            Image(systemName: "plus")
                                .padding()
                        })
                        .alert("Congratulations!", isPresented: $showingAlert) {
                            Button("OK", role: .cancel) {
                                goBackToRoot()
                            }
                        } message: {
                            Text("Keep going. It takes time to develop a habit.")
                        }
                    }
                    
                }
            }
            .frame(width: geometry.size.width, height: 170, alignment: .topLeading)
            .background(Color.darkBackground.edgesIgnoringSafeArea(.bottom))
            .clipShape(RoundedRectangle(cornerRadius: 35))
        }
        .padding(.horizontal, 10)
        .navigationTitle("HabitTracker")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func increaseCompletionCount() {
        let updatedActivity = Activity(title: item.title, description: item.description, hasDescription: item.hasDescription, completionCount: item.completionCount + 1)
        
        if let index = activityList.activities.firstIndex(of: item) {
            activityList.activities[index] = updatedActivity
            showingAlert = true
        }
    }
}

struct ActivityDetailScreen_Previews: PreviewProvider {
    static let activity = Activity(title: "Habit Title", description: "Habit description",  hasDescription: true,completionCount: 3)
    
    static let activityList = ActivityList()
    
    static var previews: some View {
        ActivityDetailScreen(activityList: activityList, item: activity, goBackToRoot: {})
    }
}
