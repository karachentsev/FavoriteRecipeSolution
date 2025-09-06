//
//  RecipeDetailsCache.swift
//  FavoriteRecipeLibrary
//
//  Created by Karachentsev Oleksandr on 05.09.2025.
//

extension FRLib {

    // MARK: - RecipeDetailsCachable

    @MainActor
    public protocol RecipeDetailsCachable {
        func set(_ values: [RecipeDetails]?, for key: String) async
        func values(for key: String) async -> [RecipeDetails]?
        func value(by id: String) async -> RecipeDetails?
    }

    // MARK: - RecipeDetailsCache

    public final class RecipeDetailsCache: Sendable, RecipeDetailsCachable {

        // MARK: - Static properties

        public static let shared = RecipeDetailsCache()

        // MARK: - Properties

        private let cache = MemoryCache<RecipeDetails>()

        // MARK: - Actions

        public func set(_ values: [RecipeDetails]?, for key: String) async {
            await cache.set(values, for: key)
        }

        public func values(for key: String) async -> [RecipeDetails]? {
            return await cache.values(for: key)
        }

        public func value(by id: String) async -> RecipeDetails? {
            return await cache.value(by: id)
        }
    }
}
