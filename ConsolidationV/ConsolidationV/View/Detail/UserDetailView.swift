//
//  UserDetailView.swift
//  ConsolidationV
//
//  Created by Can Önal on 23.09.22.
//

import SwiftUI

struct UserDetailView: View {
    let user: CachedUser
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    ProfileImage(user: user, parentGeometry: geometry)
                        .padding(.bottom)
                    
                    Text(user.wrappedCompany)
                        .font(.title3)
                    
                    Text(user.wrappedEmail)
                        .foregroundColor(.secondary)
                        .font(.callout)
                    
                    HStack(spacing: 5) {
                        Circle()
                            .fill(user.isActive ? .green : .red)
                            .frame(width: 9, height: 9)
                        
                        Text(user.isActive ? "Active" : "Inactive")
                            .font(.callout)
                            .foregroundColor(user.isActive ? .green : .red)
                    }
                    
                    Text(user.wrappedRegistered.getFormattedDate(format: "MMM d, yyyy"))
                        .font(.footnote)
                        .foregroundColor(.secondary)
            
                    
                    CustomDivider()
                    
                    VStack(alignment: .leading) {
                        Section {
                        Text(user.wrappedAbout)
                        } header: {
                            Text("About")
                                .font(.title2)
                                .bold()
                                .padding(.bottom, 5)
                        }
                    }
                    .padding(.horizontal)
                    
                    VStack(alignment: .leading) {
                        Section {
                            FriendsView(friends: user.wrappedFriends)
                        } header: {
                            Text("Friends")
                                .font(.title2)
                                .bold()
                                .padding(.vertical, 5)
                        }
                    }
                    .padding(.horizontal)
                        
                }
            }
        }
        .navigationTitle(user.wrappedName)
        .navigationBarTitleDisplayMode(.inline)
    }
}
