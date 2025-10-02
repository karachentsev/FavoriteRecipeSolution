//
//  CategoryListViewModelTests.swift
//  FavoriteRecipeLibrary
//
//  Created by Karachentsev Oleksandr on 01.10.2025.
//

import Testing
@testable import FavoriteRecipeLibrary

@MainActor
struct CategoryListViewModelTests {

    @Test
    func testLoadingCategories() async {
        let categories = (0..<5).map(FRLib.Category.makeRandomItem)
        let sut = FRLib.CategoryListViewModel(networkService: NetworkServiceStub(categories: categories), appRouter: AppRouterMock())
        await sut.fetchCategories()
        #expect(sut.categories == categories)
        #expect(sut.error == nil)
    }

    @Test
    func testLoadingCategoriesTwice() async {
        let categories = (0..<5).map(FRLib.Category.makeRandomItem)
        let sut = FRLib.CategoryListViewModel(networkService: NetworkServiceStub(categories: categories), appRouter: AppRouterMock())
        let task = Task { await sut.fetchCategories() }
        Task { await sut.fetchCategories() }
        await Task.yield()
        await task.value
        #expect(sut.categories == categories)
        #expect(sut.error == nil)
    }

    @Test
    func testReceivingError() async {
        let sut = FRLib.CategoryListViewModel(networkService: NetworkServiceStub(hasError: true), appRouter: AppRouterMock())
        await sut.fetchCategories()
        #expect(sut.categories.isEmpty)
        #expect(sut.error != nil)
    }

    @Test
    func testIsLoading() async {
        let sut = FRLib.CategoryListViewModel(networkService: NetworkServiceStub(), appRouter: AppRouterMock())
        let task = Task { await sut.fetchCategories() }
        await Task.yield()
        #expect(sut.isLoading)
        await task.value
        #expect(!sut.isLoading)
    }
}
