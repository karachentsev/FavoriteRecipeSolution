//
//  FavoriteRecipeListViewModelPreview.swift
//  FavoriteRecipeLibrary
//
//  Created by Karachentsev Oleksandr on 30.08.2025.
//

import Foundation

#if DEBUG
extension FRLib.FavoriteRecipeListViewModel {
    public static func preview(count: Int = 10) -> FRLib.FavoriteRecipeListViewModel {
        return .init(storageService: StorageServiceMock(), storagePublishService: StoragePublishServiceStub(count: count),
                     appRouter: AppRouterMock())
    }
}
#endif
