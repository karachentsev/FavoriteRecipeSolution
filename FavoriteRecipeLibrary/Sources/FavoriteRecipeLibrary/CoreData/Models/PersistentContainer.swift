//
//  PersistentContainer.swift
//  FavoriteRecipeLibrary
//
//  Created by Karachentsev Oleksandr on 17.08.2025.
//

import CoreData

extension FRLib {
    public final class PersistentContainer: Sendable {

        // MARK: - Static properties

        public static let shared = PersistentContainer()

        // MARK: - Properties

        public let storageService: StorageServicing
        public let storagePublishService: StoragePublishServicing
        private let container: NSPersistentContainer

        // MARK: - Init / Deinit

        private init() {
            let bundle = Bundle.module
            guard let modelURL = bundle.url(forResource: "FavoriteRecipe", withExtension: "momd"),
                  let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
                fatalError("Failed to load Core Data model from package bundle")
            }

            container = NSPersistentContainer(name: "FavoriteRecipe", managedObjectModel: managedObjectModel)

            guard let description = container.persistentStoreDescriptions.first else {
                fatalError("Failed to retrieve a persistent store description")
            }

            // Enable persistent store remote change notifications
            description.setOption(true as NSNumber, forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)
            // Enable persistent history tracking
            description.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)

            container.loadPersistentStores { storeDescription, error in
                if let error = error as NSError? {
                    fatalError("Unresolved error \(error), \(error.userInfo)")
                }
            }

            ValueTransformer.setValueTransformer(IngredientArrayTransformer(),
                                                 forName: NSValueTransformerName("IngredientArrayTransformer"))

            storageService = StorageService(container)
            storagePublishService = StoragePublishService(container)
        }
    }
}
