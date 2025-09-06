//
//  ServiceAssembly.swift
//  FavoriteRecipeiOS
//
//  Created by Karachentsev Oleksandr on 29.07.2025.
//

import UIKit
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

    func makeRootViewController() -> UIViewController {
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
        let viewController = UIHostingController(rootView: RootView(viewModel: viewModel))
        return viewController
    }

    func makeRecipeListViewController(for category: FRLib.Category) -> UIViewController {
        let recipeListViewModel = FRLib.RecipeListViewModel(category, appRouter: appRouter)
        let viewModel = RecipeListViewModel(recipeListViewModel: recipeListViewModel)
        let viewController = UIHostingController(rootView: RecipeListView(viewModel: viewModel))
        return viewController
    }

    func makeRecipeDetailsViewController(for id: String) -> UIViewController {
        let viewModel = FRLib.RecipeDetailsViewModel(id: id, storageService: persistentContainer.storageService,
                                                     storagePublishService: persistentContainer.storagePublishService,
                                                     appRouter: appRouter)
        let viewController = UIHostingController(rootView: RecipeDetailsView(viewModel: viewModel))
        return viewController
    }
}
