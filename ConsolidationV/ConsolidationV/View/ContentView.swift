//
//  ContentView.swift
//  ConsolidationV
//
//  Created by Can Önal on 23.09.22.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var cachedUsers: FetchedResults<CachedUser>
    
    @State private var users = [User]()
    
    var body: some View {        
        NavigationView {
            List(cachedUsers, id: \.self) { user in
                NavigationLink(destination: UserDetailView(user: user)) {
                    UserItem(user: user)
                }
            }
            .task {
                await loadData()
            }
            .navigationTitle("Users")
            .preferredColorScheme(.dark)
        }
    }
    
    private func loadData() async {
        if users.isEmpty {
            guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
                print("invalid URL")
                return
            }
            
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                if let decodedResponse = try? decoder.decode([User].self, from: data) {
                    users = decodedResponse
                }
            } catch {
                print("Invalid data")
            }
            
            await MainActor.run {
                for user in users {
                    let cachedUser = CachedUser(context: moc)
                    cachedUser.id = user.id
                    cachedUser.name = user.name
                    cachedUser.company = user.company
                    cachedUser.about = user.about
                    cachedUser.email = user.email
                    cachedUser.registered = user.registered
                    cachedUser.isActive = user.isActive
                    
                    var cachedFriends = [CachedFriend]()
                    
                    for friend in user.friends {
                        let cachedFriend = CachedFriend(context: moc)
                        cachedFriend.id = friend.id
                        cachedFriend.name = friend.name
                        cachedFriends.append(cachedFriend)
                    }
                    
                    cachedUser.cachedFriend = NSSet(array: cachedFriends)
                    
                    if moc.hasChanges {
                        try? moc.save()
                    }
                }
            }
        }
    }
}

struct UserItem: View {
    let user: CachedUser
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(user.wrappedName)
                .font(.headline)
            
            Text(user.wrappedCompany)
                .foregroundColor(.secondary)
                .italic()
            
            Text(user.isActive ? "Active" : "Inactive")
                .font(.callout)
                .foregroundColor(user.isActive ? .green : .red)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
