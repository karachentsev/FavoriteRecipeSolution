//
//  RecipeDetailsViewModelPreview.swift
//  FavoriteRecipeLibrary
//
//  Created by Karachentsev Oleksandr on 30.08.2025.
//

import Foundation

#if DEBUG
extension FRLib.RecipeDetailsViewModel {
    public static func preview(id: String? = nil, count: Int = 10) -> FRLib.RecipeDetailsViewModel {
        return .init(id: id, networkService: NetworkServiceStub(count: count), storageService: StorageServiceMock(),
                     storagePublishService: StoragePublishServiceStub(count: count), appRouter: AppRouterMock())
    }
}
#endif
