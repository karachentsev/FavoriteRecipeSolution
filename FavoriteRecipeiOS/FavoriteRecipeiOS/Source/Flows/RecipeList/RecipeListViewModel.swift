//
//  RecipeListViewModel.swift
//  FavoriteRecipeiOS
//
//  Created by Karachentsev Oleksandr on 30.07.2025.
//

import Foundation
import FavoriteRecipeLibrary

@MainActor
final class RecipeListViewModel: ObservableObject {

    // MARK: - Properties

    let recipeListViewModel: FRLib.RecipeListViewModel

    // MARK: - Init / Deinit

    init(recipeListViewModel: FRLib.RecipeListViewModel) {
        self.recipeListViewModel = recipeListViewModel
    }
}
