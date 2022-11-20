//
//  CachedUser+CoreDataProperties.swift
//  ConsolidationV
//
//  Created by Can Önal on 24.09.22.
//
//

import Foundation
import CoreData


extension CachedUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedUser> {
        return NSFetchRequest<CachedUser>(entityName: "CachedUser")
    }

    @NSManaged public var id: String?
    @NSManaged public var isActive: Bool
    @NSManaged public var name: String?
    @NSManaged public var age: Int16
    @NSManaged public var company: String?
    @NSManaged public var email: String?
    @NSManaged public var address: String?
    @NSManaged public var about: String?
    @NSManaged public var registered: Date?
    @NSManaged public var tags: String?
    @NSManaged public var cachedFriend: NSSet?
    
    public var wrappedId: String {
        id ?? "Unknown ID"
    }

    public var wrappedIsActive: Bool {
        isActive
    }
    
    public var wrappedName: String {
        name ?? "Unknown Name"
    }
    
    public var wrappedCompany: String {
        company ?? "Unknown Company"
    }
    
    public var wrappedEmail: String {
        email ?? "Unknown Email"
    }
    
    public var wrappedAbout: String {
        about ?? "Unknown About"
    }
    
    public var wrappedRegistered: Date {
        registered ?? Date.now
    }
    
    public var wrappedFriends: [CachedFriend] {
        let set = cachedFriend as? Set<CachedFriend> ?? []
        
        return set.sorted {
            $0.id < $1.id
        }
    }
}

// MARK: Generated accessors for cachedFriend
extension CachedUser {

    @objc(addCachedFriendObject:)
    @NSManaged public func addToCachedFriend(_ value: CachedFriend)

    @objc(removeCachedFriendObject:)
    @NSManaged public func removeFromCachedFriend(_ value: CachedFriend)

    @objc(addCachedFriend:)
    @NSManaged public func addToCachedFriend(_ values: NSSet)

    @objc(removeCachedFriend:)
    @NSManaged public func removeFromCachedFriend(_ values: NSSet)

}

extension CachedUser : Identifiable {

}
