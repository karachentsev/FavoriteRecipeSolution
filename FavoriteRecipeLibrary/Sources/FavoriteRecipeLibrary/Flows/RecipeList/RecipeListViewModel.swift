//
//  RecipeListViewModel.swift
//  FavoriteRecipeLibrary
//
//  Created by Karachentsev Oleksandr on 29.07.2025.
//

import Foundation

extension FRLib {
    @MainActor
    public final class RecipeListViewModel: ObservableObject {

        // MARK: - Properties

        @Published private(set) var recipes = [Recipe]()
        @Published private(set) var isLoading = false
        @Published var error: CustomError?
        public let category: Category
        private let networkService: NetworkServicing
        private let appRouter: AppRouting

        // MARK: - Init / Deinit

        public init(_ category: Category, networkService: NetworkServicing = NetworkService.shared, appRouter: AppRouting) {
            self.category = category
            self.networkService = networkService
            self.appRouter = appRouter
        }

        // MARK: - Actions

        func fetchRecipes() async {
            guard !isLoading else { return }
            isLoading = true
            error = nil
            do {
                recipes = try await networkService.getRecipes(categoryName: category.name)
            } catch {
                self.error = .network(desc: error.localizedDescription)
            }
            isLoading = false
        }

        public func close() {
            appRouter.closeRecipeList(for: category)
        }

        func showRecipe(id: String) {
            appRouter.showRecipe(id: id)
        }
    }
}
