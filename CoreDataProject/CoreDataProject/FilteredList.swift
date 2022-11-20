//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by Can Önal on 19.09.22.
//

import CoreData
import SwiftUI

struct FilteredList<T: NSManagedObject, Content: View>: View {
    @FetchRequest var fetchRequest: FetchedResults<T>
    
    let content: (T) -> Content
    
    var body: some View {
        List(fetchRequest, id: \.self) { item in
            self.content(item)
        }
    }
    
    init(
        sortDescriptors: [SortDescriptor<T>],
        predicateType: PredicateType,
        filterKey: String,
        filterValue: String,
        @ViewBuilder content: @escaping (T) -> Content) {
            var predicateString: String
            
            switch(predicateType) {
            case .beginswith:
                predicateString = "%K BEGINSWITH %@"
            }
            
            _fetchRequest = FetchRequest<T>(sortDescriptors: sortDescriptors, predicate: NSPredicate(format: predicateString, filterKey ,filterValue))
            self.content = content
        }
}

enum PredicateType {
    case beginswith
}
