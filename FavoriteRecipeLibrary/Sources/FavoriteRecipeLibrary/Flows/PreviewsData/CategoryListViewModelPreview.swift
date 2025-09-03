//
//  CategoryListViewModelPreview.swift
//  FavoriteRecipeLibrary
//
//  Created by Karachentsev Oleksandr on 29.07.2025.
//

import Foundation

#if DEBUG
extension FRLib.CategoryListViewModel {
    public static func preview(count: Int = 10) -> FRLib.CategoryListViewModel {
        return .init(networkService: NetworkServiceStub(count: count), appRouter: AppRouterMock())
    }

    public static func previewError() -> FRLib.CategoryListViewModel {
        return .init(networkService: NetworkServiceStub(hasError: true), appRouter: AppRouterMock())
    }
}
#endif
