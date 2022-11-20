//
//  AddActivitySheet.swift
//  HabitTracker
//
//  Created by Can Önal on 02.09.22.
//

import Combine
import SwiftUI

struct AddActivityScreen: View {
    @ObservedObject var activityList: ActivityList
    
    @Environment(\.dismiss) var dismiss
    
    @State private var activityTitle = ""
    @State private var activityDescription = ""
    @State private var showErrorAlert = false
    
    let titleLimit = 25
    let descriptionLimit = 35
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                TextField("", text: $activityTitle)
                    .padding()
                    .font(.title)
                    .onReceive(Just(activityTitle)) { _ in
                        limitTitle(titleLimit)
                    }
                    .placeHolder(when: activityTitle.isEmpty) {
                        Text("Title")
                            .padding()
                            .foregroundColor(.primary)
                            .font(.title)
                    }
                
                TextField("Description", text: $activityDescription)
                    .padding(.horizontal)
                    .onReceive(Just(activityDescription)) { _ in
                        limitDescription(descriptionLimit)
                    }
                
                Spacer()
            }
            .navigationTitle("Add New Habit")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button("Save") {
                    checkFields()
                }
            .alert("Error", isPresented: $showErrorAlert) {
                    Button("OK", role: .cancel) {}
            } message: {
                Text("Title can not be empty!")
            }
            }
        }
    }
    
    private func checkFields() {
        guard activityTitle != "" else {
            showErrorAlert = true
            return
        }
        saveActivity()
    }
    
    private func saveActivity() {
        let hasDescription = !activityDescription.isEmpty
        let activity = Activity(title: activityTitle, description: activityDescription, hasDescription: hasDescription ,completionCount: 0)
        activityList.activities.append(activity)
        dismiss()
    }
    
    private func limitTitle(_ upper: Int) {
        if activityTitle.count > upper {
            activityTitle = String(activityTitle.prefix(upper))
        }
    }
    
    private func limitDescription(_ upper: Int) {
        if activityDescription.count > upper {
            activityDescription = String(activityDescription.prefix(upper))
        }
    }
}

extension View {
    func placeHolder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content
    ) -> some View {
        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}

struct AddActivityScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddActivityScreen(activityList: ActivityList())
    }
}
