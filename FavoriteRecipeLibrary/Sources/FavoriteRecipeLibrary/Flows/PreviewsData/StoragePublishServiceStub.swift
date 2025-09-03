//
//  StoragePublishServiceStub.swift
//  FavoriteRecipeLibrary
//
//  Created by Karachentsev Oleksandr on 30.08.2025.
//

import Foundation

#if DEBUG
actor StoragePublishServiceStub: FRLib.StoragePublishServicing {
    
    // MARK: - Properties
    
    let count: Int

    // MARK: - Init / Deinit

    init(count: Int) {
        self.count = count
    }

    // MARK: - Actions
    
    func getRecipeDetails(id: String) async -> FRLib.RecipeDetails? {
        return .preview
    }
    
    func getFavoriteRecipeStream(id: String) -> AsyncStream<FRLib.RecipeDetails> {
        return AsyncStream { continuation in
            continuation.yield(.preview)
            continuation.finish()
        }
    }
    
    func getFavoriteRecipesStream(sortedBy: FRLib.StoragePublishService.SortedBy) -> AsyncStream<[[FRLib.FavoriteRecipe]]> {
        return AsyncStream { continuation in
            var recipes = [FRLib.FavoriteRecipe]()
            for i in 0..<count {
                recipes.append(.makeRandomItem(for: i))
            }
            recipes.sort { lhs, rhs -> Bool in
                switch sortedBy {
                case .name:
                    return lhs.name < rhs.name
                case .categoryName:
                    return lhs.categoryName < rhs.categoryName
                case .area:
                    return lhs.area < rhs.area
                }
            }
            var sectioned = [[FRLib.FavoriteRecipe]]()
            for recipe in recipes {
                guard !sectioned.isEmpty else {
                    sectioned.append([recipe])
                    continue
                }

                switch sortedBy {
                case .name:
                    sectioned[0].append(recipe)
                case .categoryName:
                    if sectioned.last?.first?.categoryName != recipe.categoryName {
                        sectioned.append([recipe])
                    } else {
                        sectioned[sectioned.count - 1].append(recipe)
                    }
                case .area:
                    if sectioned.last?.first?.area != recipe.area {
                        sectioned.append([recipe])
                    } else {
                        sectioned[sectioned.count - 1].append(recipe)
                    }
                }
            }
            continuation.yield(sectioned)
            continuation.finish()
        }
    }
}
#endif
