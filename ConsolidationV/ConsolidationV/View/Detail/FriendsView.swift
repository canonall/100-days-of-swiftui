//
//  FriendsView.swift
//  ConsolidationV
//
//  Created by Can Önal on 23.09.22.
//

import SwiftUI

struct FriendsView: View {
    
    let friends: [CachedFriend]
    let columns = [GridItem(.flexible()),
                   GridItem(.flexible())]
    
    var body: some View {
        LazyVGrid(columns: columns) {
            ForEach(friends, id: \.self){ friend in
                FriendItem(friend: friend)
            }
        }
    }
}

struct FriendItem: View {
    let friend: CachedFriend
    
    var body: some View {
        ZStack {
            Capsule()
                .foregroundColor(.secondary)
            
            Text(friend.wrappedName)
                .multilineTextAlignment(.center)
                .padding()
        }
    }
}
