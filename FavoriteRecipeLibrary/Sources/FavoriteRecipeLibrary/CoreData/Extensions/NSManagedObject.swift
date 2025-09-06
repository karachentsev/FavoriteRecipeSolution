//
//  NSManagedObject.swift
//  FavoriteRecipeLibrary
//
//  Created by Karachentsev Oleksandr on 17.08.2025.
//

import CoreData

extension Entity where Self: NSManagedObject {
    static func findFirst(by id: String, in context: NSManagedObjectContext) -> Self? {
        return findFirst(with: NSPredicate(format: "\(Self.primaryKey) == %@", id), in: context)
    }

    static func findFirst(with predicate: NSPredicate, in context: NSManagedObjectContext) -> Self? {
        return findAll(with: predicate, fetchLimit: 1, in: context)?.first
    }

    static func findAll(with predicate: NSPredicate? = nil, sortDescriptors: [NSSortDescriptor]? = nil,
                        fetchLimit: Int? = nil, fetchOffset: Int? = nil, in context: NSManagedObjectContext) -> [Self]? {
        guard let entityName = entity().name else {
            fatalError("\(Self.description()) must have NSEntityDescription")
        }

        let fetchRequest = NSFetchRequest<Self>(entityName: entityName)
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = sortDescriptors
        if let fetchLimit {
            fetchRequest.fetchLimit = fetchLimit
        }
        if let fetchOffset {
            fetchRequest.fetchOffset = fetchOffset
        }
        fetchRequest.returnsObjectsAsFaults = true
        let managedObjectContext = context
        return (try? managedObjectContext.fetch(fetchRequest))
    }

    static func create(in context: NSManagedObjectContext) -> Self {
        guard let result = NSEntityDescription.insertNewObject(forEntityName: Self.className, into: context) as? Self else {
            fatalError("Could not insert \(Self.className) into \(context)")
        }

        return result
    }
}
