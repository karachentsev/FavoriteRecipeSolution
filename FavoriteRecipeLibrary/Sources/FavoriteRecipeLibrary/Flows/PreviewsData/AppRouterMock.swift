//
//  AppRouterMock.swift
//  FavoriteRecipeLibrary
//
//  Created by Karachentsev Oleksandr on 29.07.2025.
//

import Foundation

#if DEBUG
struct AppRouterMock: FRLib.AppRouting {
    func showRecipeList(for category: FRLib.Category) {

    }

    func closeRecipeList(for category: FRLib.Category) {

    }

    func showRecipe(id: String) {

    }

    func closeRecipe(id: String) {

    }

    func showYouTube(for url: URL) {

    }

    func closeYouTube(for url: URL) {

    }
}
#endif
