//
//  CategoryListViewModel.swift
//  FavoriteRecipeLibrary
//
//  Created by Karachentsev Oleksandr on 29.07.2025.
//

import Foundation
import Combine

extension FRLib {
    @MainActor
    public final class CategoryListViewModel: ObservableObject {

        // MARK: - Properties

        @Published private(set) var categories = [Category]()
        @Published private(set) var isLoading = false
        @Published var error: CustomError?
        private let networkService: NetworkServicing
        private let appRouter: AppRouting

        // MARK: - Init / Deinit

        public init(networkService: NetworkServicing = NetworkService.shared, appRouter: AppRouting) {
            self.networkService = networkService
            self.appRouter = appRouter
        }

        // MARK: - Actions

        public func fetchCategories() async {
            guard !isLoading else { return }
            isLoading = true
            error = nil
            do {
                categories = try await networkService.getCategories()
            } catch {
                self.error = .network(desc: error.localizedDescription)
            }
            isLoading = false
        }

        func showRecipeList(for category: Category) {
            appRouter.showRecipeList(for: category)
        }
    }
}
