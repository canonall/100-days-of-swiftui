//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Can Önal on 27.10.22.
//

import CodeScanner
import SwiftUI
import UserNotifications

struct ProspectsView: View {
    @EnvironmentObject var prospects: Prospects
    @State private var isShowingScanner = false
    @State private var isShowingSortDialog = false
    
    let filter: FilterType
    
    var title: String {
        switch filter {
        case .none:
            return "Everyone"
        case .contacted:
            return "Contacted people"
        case .uncontacted:
            return "Uncontacted people"
        }
    }
    
    var filteredProspects: [Prospect] {
        switch filter {
        case .none:
            return prospects.people
        case .contacted:
            return prospects.people.filter { prospect in
                prospect.isContacted
            }
        case .uncontacted:
            return prospects.people.filter { prospect in
                !prospect.isContacted
            }
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredProspects) { prospect in
                   ProspectItem(prospect: prospect, filter: filter)
                }
            }
            .navigationTitle(title)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button() {
                        isShowingScanner = true
                    } label: {
                        Label("Scan", systemImage: "qrcode.viewfinder")
                    }
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        isShowingSortDialog = true
                    } label: {
                        Text("Sort")
                    }
                }
            }
            .sheet(isPresented: $isShowingScanner) {
                CodeScannerView(codeTypes: [.qr], simulatedData: "Nastassia\nLebron@mail.com", completion: handleScan)
            }
            .confirmationDialog("Sort", isPresented: $isShowingSortDialog) {
                Button("By name") {
                    prospects.sortByName()
                }
                Button("By most recent") { prospects.sortByMostRecent() }
            }
        }
    }
    
    func handleScan(result: Result<ScanResult, ScanError>) {
        isShowingScanner = false
        
        switch result {
        case .success(let result):
            let details = result.string.components(separatedBy: "\n")
            guard details.count == 2 else { return }
            
            let person = Prospect()
            person.name = details[0]
            person.emailAddress = details[1]
            prospects.add(prospect: person)
        case .failure(let error):
            print("Scanning failed: \(error.localizedDescription)")
        }
    }
}

struct ProspectItem: View {
    
    @EnvironmentObject var prospects: Prospects
    
    let prospect: Prospect
    let filter: FilterType
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(prospect.name)
                    .font(.headline)
                Text(prospect.emailAddress)
                    .foregroundColor(.secondary)
            }
            Spacer()
            if(filter == .none) {
                if(prospect.isContacted) {
                    Image(systemName: "person.fill.checkmark")
                } else {
                    Image(systemName: "person.fill.xmark")
                }
            }
        }
        .swipeActions {
            if prospect.isContacted {
                Button {
                    prospects.toggle(prospect)
                } label: {
                    Label("Mark Uncontacted", systemImage: "person.crop.circle.badge.xmark")
                }
                .tint(.red)
            } else {
                Button {
                    prospects.toggle(prospect)
                } label: {
                    Label("Mark Contacted", systemImage: "person.crop.circle.fill.badge.checkmark")
                }
                .tint(.green)
                
                Button {
                    addNotifocation(for: prospect)
                } label: {
                    Label("Remind me ", systemImage: "bell")
                }
                .tint(.orange)
            }
        }
    }
    func addNotifocation(for prospect: Prospect) {
        let center = UNUserNotificationCenter.current()
        
        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = prospect.emailAddress
            content.sound = UNNotificationSound.default
            
            var dateComponents = DateComponents()
            dateComponents.hour = 9
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            //  let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false) -> for testing
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
        }
        
        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        addRequest()
                    } else {
                        print("Nope")
                    }
                }
            }
        }
    }
}

enum FilterType {
    case none, contacted, uncontacted
}

struct ProspectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProspectsView(filter: .none)
            .environmentObject(Prospects())
    }
}
