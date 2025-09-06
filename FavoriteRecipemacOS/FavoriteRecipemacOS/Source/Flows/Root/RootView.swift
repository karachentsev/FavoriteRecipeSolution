//
//  RootView.swift
//  FavoriteRecipemacOS
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
        NavigationSplitView {
            VStack(alignment: .leading) {
                ForEach(FRLib.SelectedTab.allCases) { item in
                    Button {
                        selectedTab = item
                    } label: {
                        HStack {
                            Image(systemName: item.systemName)
                            Text(item.title)
                        }
                        .padding([.leading, .trailing], 8)
                        .padding([.top, .bottom], 16)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(item == selectedTab ? Color(NSColor.controlAccentColor) : Color.clear)
                        .contentShape(Rectangle())
                    }
                    .buttonStyle(PlainButtonStyle())
                    .allowsHitTesting(item != selectedTab)
                }
                Spacer()
            }
        } detail: {
            switch selectedTab {
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
        .navigationTitle("Favorite Recipe")
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
