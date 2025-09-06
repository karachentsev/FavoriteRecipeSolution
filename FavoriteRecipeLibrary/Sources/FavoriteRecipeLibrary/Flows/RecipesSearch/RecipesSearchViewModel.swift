//
//  RecipesSearchViewModel.swift
//  FavoriteRecipeLibrary
//
//  Created by Karachentsev Oleksandr on 04.09.2025.
//

import Foundation
import Combine

extension FRLib {
    @MainActor
    public final class RecipesSearchViewModel: ObservableObject {

        // MARK: - Constants

        public enum Constants {
            static let minCharactersCount = 2
        }

        // MARK: - Properties

        @Published public var inputQuery = ""
        @Published private(set) var recipes = [RecipeDetails]()
        @Published private(set) var isLoading = false
        @Published var showingAlert = false
        private let cache: RecipeDetailsCachable
        private(set) var error: CustomError? { didSet { showingAlert = error != nil } }
        private let networkService: NetworkServicing
        private let appRouter: AppRouting
        private var subscription: AnyCancellable?
        private var task: (Task<(), Never>)?

        // MARK: - Getters properties

        var hasSearched: Bool { task != nil }

        // MARK: - Init / Deinit

        public init(networkService: NetworkServicing = NetworkService.shared,
                    cache: RecipeDetailsCachable = RecipeDetailsCache.shared, appRouter: AppRouting) {
            self.networkService = networkService
            self.cache = cache
            self.appRouter = appRouter
            setup()
        }

        // MARK: - Setup

        private func setup() {
            subscription = $inputQuery
                .dropFirst(1)
                .map { $0.trimmingCharacters(in: .whitespaces) }
                .filter { [weak self] text in
                    if let self {
                        task?.cancel()
                        task = nil
                        recipes.removeAll()
                        isLoading = false
                    }
                    return text.count >= Constants.minCharactersCount
                }
                .removeDuplicates()
                .debounce(for: 1, scheduler: DispatchQueue.main)
                .sink { [weak self] query in
                    guard let self else { return }
                    task = Task {
                        await fetchRecipes(query)
                    }
                }
        }

        // MARK: - Actions

        func fetchRecipes(_ query: String) async {
            error = nil

            if let cached = await cache.values(for: query) {
                recipes = cached
                return
            }

            isLoading = true
            do {
                let searchedRecipes = try await networkService.searchRecipes(query: query)
                await cache.set(searchedRecipes, for: query)
                guard !Task.isCancelled else { return }
                recipes = searchedRecipes
            } catch {
                guard !Task.isCancelled else { return }
                self.error = .network(desc: error.localizedDescription)
            }
            isLoading = false
        }

        func showRecipe(id: String) {
            appRouter.showRecipe(id: id)
        }
    }
}
