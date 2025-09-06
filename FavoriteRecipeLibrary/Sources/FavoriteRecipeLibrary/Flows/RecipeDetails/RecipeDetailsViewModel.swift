//
//  RecipeDetailsViewModel.swift
//  FavoriteRecipeLibrary
//
//  Created by Karachentsev Oleksandr on 17.08.2025.
//

import Foundation
import Combine

extension FRLib {
    @MainActor
    public final class RecipeDetailsViewModel: ObservableObject {

        // MARK: - Static properties

        static let randomId = "RecipeDetailsRandomId"

        // MARK: - Properties

        @Published public private(set) var recipeDetails: RecipeDetails?
        @Published public private(set) var isFavorite = false
        @Published public private(set) var isLoading = true
        @Published public private(set) var error: CustomError?
        private let isRandom: Bool
        private let networkService: NetworkServicing
        private let storageService: StorageServicing
        private let storagePublishService: StoragePublishServicing
        private let cache: RecipeDetailsCachable
        private let appRouter: AppRouting
        public private(set) var id: String?
        private var recipeStreamTask: Task<(), Never>?

        // MARK: - Init / Deinit

        public init(id: String?, networkService: NetworkServicing = NetworkService.shared, storageService: StorageServicing,
                    storagePublishService: StoragePublishServicing, cache: RecipeDetailsCachable = RecipeDetailsCache.shared,
                    appRouter: AppRouting) {
            self.id = id
            self.isRandom = id == nil || id?.isEmpty == true
            self.networkService = networkService
            self.storageService = storageService
            self.storagePublishService = storagePublishService
            self.cache = cache
            self.appRouter = appRouter
        }

        deinit {
            recipeStreamTask?.cancel()
        }

        // MARK: - Setup

        private func setup() async {
            guard let id else { return }
            let stream = await storagePublishService.getFavoriteRecipeStream(id: id)
            recipeStreamTask?.cancel()
            recipeStreamTask = Task { [weak self] in
                for await item in stream {
                    self?.isFavorite = item.isFavorite
                }
            }
        }

        // MARK: - Actions

        public func loadData() async {
            guard let id else { fatalError("id must be set!") }
            await setup()
            error = nil
            recipeDetails = await storagePublishService.getRecipeDetails(id: id)
            if let recipeDetails {
                isFavorite = recipeDetails.isFavorite
                isLoading = false
            }

            if let cached = await cache.value(by: id) {
                recipeDetails = cached
                isLoading = false
                return
            }

            do {
                recipeDetails = try await networkService.getRecipeDetails(id: id)
            } catch {
                self.error = .network(desc: error.localizedDescription)
            }
            isLoading = false
        }

        public func loadRandomData() async {
            id = nil
            recipeDetails = nil
            isFavorite = false
            error = nil
            isLoading = true

            do {
                let item = try await networkService.getRandomRecipeDetails()
                id = item.id
                await setup()
                recipeDetails = item
            } catch {
                self.error = .network(desc: error.localizedDescription)
            }
            if let id {
                isFavorite = (await storagePublishService.getRecipeDetails(id: id))?.isFavorite ?? false
            } else {
                isFavorite = false
            }
            isLoading = false
        }

        public func updateFavorite() async {
            guard let id else { return }
            isFavorite = !isFavorite
            await storageService.updateFavoriteRecipe(id: id, recipeDetails: recipeDetails, isFavorite: isFavorite)
        }

        public func close() {
            if isRandom {
                appRouter.closeRecipe(id: Self.randomId)
            } else if let id {
                appRouter.closeRecipe(id: id)
            }
        }

        public func showYouTube() {
            guard let url = recipeDetails?.youtubeUrl else { return }
            appRouter.showYouTube(for: url)
        }
    }
}
