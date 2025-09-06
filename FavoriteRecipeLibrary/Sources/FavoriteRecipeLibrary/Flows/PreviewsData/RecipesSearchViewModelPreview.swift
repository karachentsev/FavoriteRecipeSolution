//
//  RecipesSearchViewModelPreview.swift
//  FavoriteRecipeLibrary
//
//  Created by Karachentsev Oleksandr on 04.09.2025.
//

import Foundation

#if DEBUG
extension FRLib.RecipesSearchViewModel {
    public static func preview(query: String = "", count: Int = 10, hasError: Bool = false) -> FRLib.RecipesSearchViewModel {
        let viewModel = FRLib.RecipesSearchViewModel(networkService: NetworkServiceStub(count: count, hasError: hasError),
                                                     appRouter: AppRouterMock())
        viewModel.inputQuery = query
        return viewModel
    }
}
#endif
