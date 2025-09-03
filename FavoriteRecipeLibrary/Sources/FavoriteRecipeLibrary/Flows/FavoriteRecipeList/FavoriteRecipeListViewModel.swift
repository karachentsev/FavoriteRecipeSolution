//
//  FavoriteRecipeListViewModel.swift
//  FavoriteRecipeLibrary
//
//  Created by Karachentsev Oleksandr on 30.08.2025.
//

import Foundation

extension FRLib {
    @MainActor
    public final class FavoriteRecipeListViewModel: ObservableObject {

        // MARK: - Properties

        @Published private(set) var sectionedRecipes = [[FavoriteRecipe]]()
        public private(set) var sortedBy: FRLib.StoragePublishService.SortedBy = .name
        private let storageService: StorageServicing
        private let storagePublishService: StoragePublishServicing
        private let appRouter: AppRouting
        private var favoriteRecipesStreamTask: Task<(), Never>?

        // MARK: - Init / Deinit

        public init(storageService: StorageServicing, storagePublishService: StoragePublishServicing, appRouter: AppRouting) {
            self.storageService = storageService
            self.storagePublishService = storagePublishService
            self.appRouter = appRouter

            Task {
                await setup()
            }
        }

        deinit {
            favoriteRecipesStreamTask?.cancel()
        }

        // MARK: - Setup

        private func setup() async {
            let stream = await storagePublishService.getFavoriteRecipesStream(sortedBy: sortedBy)
            favoriteRecipesStreamTask?.cancel()
            favoriteRecipesStreamTask = Task { [weak self] in
                for await items in stream {
                    self?.sectionedRecipes = items
                }
            }
        }

        // MARK: - Actions

        public func changeSorting(to sorting: FRLib.StoragePublishService.SortedBy) async {
            sortedBy = sorting
            await setup()
        }

        public func clearAll() async {
            await storageService.clearAll()
        }

        func removeFromFavorite(id: String) async {
            await storageService.updateFavoriteRecipe(id: id, recipeDetails: nil, isFavorite: false)
        }

        func showRecipe(id: String) {
            appRouter.showRecipe(id: id)
        }
    }
}
