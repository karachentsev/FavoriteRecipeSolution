//
//  StorageService.swift
//  FavoriteRecipeLibrary
//
//  Created by Karachentsev Oleksandr on 17.08.2025.
//

import CoreData

extension FRLib {

    // MARK: - StorageServicing

    public protocol StorageServicing: Actor {
        func updateFavoriteRecipe(id: String, recipeDetails: FRLib.RecipeDetails?, isFavorite: Bool) async
        func clearAll() async
    }

    // MARK: - StorageService

    public actor StorageService: StorageServicing {

        // MARK: - Properties

        private let context: NSManagedObjectContext

        // MARK: - Init / Deinit

        init(_ container: NSPersistentContainer) {
            context = container.newBackgroundContext()
        }
    }
}

extension FRLib.StorageService {
    public func updateFavoriteRecipe(id: String, recipeDetails: FRLib.RecipeDetails?, isFavorite: Bool) async {
        context.performAndWait {
            if let entity = RecipeDetailsEntity.findFirst(by: id, in: context) {
                entity.isFavorite = isFavorite
            } else if let recipeDetails {
                let entity = RecipeDetailsEntity.create(in: context)
                entity.id = recipeDetails.id
                entity.name = recipeDetails.name
                entity.categoryName = recipeDetails.categoryName
                entity.area = recipeDetails.area
                entity.instructions = recipeDetails.instructions
                entity.thumbUrl = recipeDetails.thumbUrl
                entity.tags = recipeDetails.tags
                entity.youtubeUrl = recipeDetails.youtubeUrl
                entity.ingredients = recipeDetails.ingredients
                entity.isFavorite = isFavorite
            }
            context.saveSilent()
        }
    }

    public func clearAll() async {
        context.performAndWait {
            let request = NSBatchUpdateRequest(entity: RecipeDetailsEntity.entity())
            request.predicate = NSPredicate(format: "\(#keyPath(RecipeDetailsEntity.isFavorite)) == %d", true)
            request.propertiesToUpdate = [#keyPath(RecipeDetailsEntity.isFavorite): false]
            request.resultType = .statusOnlyResultType
            do {
                let result = try context.execute(request) as? NSBatchUpdateResult
                if let success = result?.result as? Bool, success {
                    print("Batch update completed successfully.")
                } else {
                    print("Batch update failed or no changes were made.")
                }
            } catch {
                print("Batch update execution failed:", error)
            }
        }
    }
}
