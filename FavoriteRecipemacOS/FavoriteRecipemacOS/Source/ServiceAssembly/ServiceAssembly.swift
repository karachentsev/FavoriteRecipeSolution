//
//  ServiceAssembly.swift
//  FavoriteRecipemacOS
//
//  Created by Karachentsev Oleksandr on 29.07.2025.
//

import AppKit
import SwiftUI
import FavoriteRecipeLibrary

@MainActor
final class ServiceAssembly {

    // MARK: - Static properties

    static let shared = ServiceAssembly()

    // MARK: - Properties

    private var persistentContainer: FRLib.PersistentContainer { .shared }
    private var appRouter: FRLib.AppRouting { AppRouter.shared }

    // MARK: - Init / Deinit

    private init() {}

    // MARK: - Actions

    func makeRootViewController() -> NSHostingController<RootView> {
        let categoryViewModel = FRLib.CategoryListViewModel(appRouter: appRouter)
        let randomViewModel = FRLib.RecipeDetailsViewModel(id: nil, storageService: persistentContainer.storageService,
                                                           storagePublishService: persistentContainer.storagePublishService,
                                                           appRouter: appRouter)
        let searchViewModel = FRLib.RecipesSearchViewModel(appRouter: appRouter)
        let favoriteViewModel = FRLib.FavoriteRecipeListViewModel(storageService: persistentContainer.storageService,
                                                                  storagePublishService: persistentContainer.storagePublishService,
                                                                  appRouter: appRouter)
        let viewModel = RootViewModel(categoryListViewModel: categoryViewModel, randomRecipeViewModel: randomViewModel,
                                      searchViewModel: searchViewModel, favoriteRecipeListViewModel: favoriteViewModel)
        let viewController = NSHostingController(rootView: RootView(viewModel: viewModel))
        return viewController
    }

    func makeRecipeListViewController(for category: FRLib.Category) -> NSHostingController<RecipeListView> {
        let recipeListViewModel = FRLib.RecipeListViewModel(category, appRouter: appRouter)
        let viewModel = RecipeListViewModel(recipeListViewModel: recipeListViewModel)
        return NSHostingController(rootView: RecipeListView(viewModel: viewModel))
    }

    func makeRecipeDetailsViewController(for id: String) -> NSHostingController<RecipeDetailsView> {
        let viewModel = FRLib.RecipeDetailsViewModel(id: id, storageService: persistentContainer.storageService,
                                                     storagePublishService: persistentContainer.storagePublishService,
                                                     appRouter: appRouter)
        let viewController = NSHostingController(rootView: RecipeDetailsView(viewModel: viewModel))
        return viewController
    }
}
