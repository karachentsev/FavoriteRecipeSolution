//
//  RootViewModel.swift
//  FavoriteRecipemacOS
//
//  Created by Karachentsev Oleksandr on 29.07.2025.
//

import Foundation
import FavoriteRecipeLibrary

final class RootViewModel: ObservableObject {

    // MARK: - Properties

    let categoryListViewModel: FRLib.CategoryListViewModel
    let randomRecipeViewModel: FRLib.RecipeDetailsViewModel
    let searchViewModel: FRLib.RecipesSearchViewModel
    let favoriteRecipeListViewModel: FRLib.FavoriteRecipeListViewModel

    // MARK: - Init / Deinit

    init(categoryListViewModel: FRLib.CategoryListViewModel, randomRecipeViewModel: FRLib.RecipeDetailsViewModel,
         searchViewModel: FRLib.RecipesSearchViewModel, favoriteRecipeListViewModel: FRLib.FavoriteRecipeListViewModel) {
        self.categoryListViewModel = categoryListViewModel
        self.randomRecipeViewModel = randomRecipeViewModel
        self.searchViewModel = searchViewModel
        self.favoriteRecipeListViewModel = favoriteRecipeListViewModel
    }
}
