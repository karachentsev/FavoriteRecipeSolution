//
//  RootView.swift
//  FavoriteRecipeiOS
//
//  Created by Karachentsev Oleksandr on 21.07.2025.
//

import SwiftUI
import FavoriteRecipeLibrary

struct RootView: View {

    // MARK: - Properties

    @ObservedObject var viewModel: RootViewModel

    @AppStorage(FRLib.UserDefaultsKeys.rootViewSelectedTab.rawValue)
    private var selectedTab: FRLib.SelectedTab = .categories

    // MARK: - Body

    var body: some View {
        TabView(selection: $selectedTab) {
            ForEach(FRLib.SelectedTab.allCases) { item in
                Tab(value: item) {
                    view(for: item)
                } label: {
                    Label(item.title, systemImage: item.systemName)
                }
            }
        }
    }

    // MARK: - Private

    @ViewBuilder
    private func view(for tab: FRLib.SelectedTab) -> some View {
        switch tab {
        case .categories:
            CategoryListView(viewModel: viewModel.categoryListViewModel)
        case .random:
            RandomRecipeView(viewModel: viewModel.randomRecipeViewModel)
        case .search:
            RecipesSearchView(viewModel: viewModel.searchViewModel)
        case .favorites:
            FavoriteRecipeListView(viewModel: viewModel.favoriteRecipeListViewModel)
        }
    }
}

#if DEBUG
#Preview {
    let count = 20
    RootView(viewModel: .init(categoryListViewModel: .preview(count: count),
                              randomRecipeViewModel: .preview(count: count),
                              searchViewModel: .preview(count: count),
                              favoriteRecipeListViewModel: .preview(count: count)))
}
#endif
