//
//  StorageServiceMock.swift
//  FavoriteRecipeLibrary
//
//  Created by Karachentsev Oleksandr on 30.08.2025.
//

import Foundation

#if DEBUG
actor StorageServiceMock: FRLib.StorageServicing {
    func updateFavoriteRecipe(id: String, recipeDetails: FRLib.RecipeDetails?, isFavorite: Bool) async {

    }

    func clearAll() async {

    }
}
#endif
