//
//  RootViewModel.swift
//  FavoriteRecipeiOS
//
//  Created by Karachentsev Oleksandr on 29.07.2025.
//

import Foundation
import FavoriteRecipeLibrary

final class RootViewModel: ObservableObject {

    // MARK: - Properties

    let categoryListViewModel: FRLib.CategoryListViewModel
    let randomRecipeViewModel: FRLib.RecipeDetailsViewModel
    let favoriteRecipeListViewModel: FRLib.FavoriteRecipeListViewModel

    // MARK: - Init / Deinit

    init(categoryListViewModel: FRLib.CategoryListViewModel, randomRecipeViewModel: FRLib.RecipeDetailsViewModel,
         favoriteRecipeListViewModel: FRLib.FavoriteRecipeListViewModel) {
        self.categoryListViewModel = categoryListViewModel
        self.randomRecipeViewModel = randomRecipeViewModel
        self.favoriteRecipeListViewModel = favoriteRecipeListViewModel
    }
}
