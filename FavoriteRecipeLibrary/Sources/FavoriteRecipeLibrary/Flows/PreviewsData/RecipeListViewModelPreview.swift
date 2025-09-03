//
//  RecipeListViewModelPreview.swift
//  FavoriteRecipeLibrary
//
//  Created by Karachentsev Oleksandr on 29.07.2025.
//

import Foundation

#if DEBUG
extension FRLib.RecipeListViewModel {
    public static func preview(count: Int = 10) -> FRLib.RecipeListViewModel {
        return .init(.makeRandomItem(for: count),
                     networkService: NetworkServiceStub(count: count), appRouter: AppRouterMock())
    }
}
#endif
