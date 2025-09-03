//
//  NSManagedObjectContext.swift
//  FavoriteRecipeLibrary
//
//  Created by Karachentsev Oleksandr on 17.08.2025.
//

import CoreData

extension NSManagedObjectContext {
    public func saveSilent() {
        do {
            try save()
        } catch {
            print("!!! \(Date()) Saving error: \(error)")
        }
    }
}
