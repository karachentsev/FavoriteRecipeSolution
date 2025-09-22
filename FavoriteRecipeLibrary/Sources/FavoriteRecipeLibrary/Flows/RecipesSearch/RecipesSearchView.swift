//
//  RecipesSearchView.swift
//  FavoriteRecipeLibrary
//
//  Created by Karachentsev Oleksandr on 04.09.2025.
//

import SwiftUI

extension FRLib {
    public struct RecipesSearchView: View {

        // MARK: - Constants

        public enum Constants {
            public static let prompt = "Type recipe name"
        }

        // MARK: - Properties

        @ObservedObject var viewModel: RecipesSearchViewModel
        @Environment(\.horizontalSizeClass) private var horizontalSizeClass

        // MARK: - Init / Deinit

        public init(viewModel: RecipesSearchViewModel) {
            self.viewModel = viewModel
        }

        // MARK: - Body

        public var body: some View {
            mainView
                .errorAlert($viewModel.error)
        }

        // MARK: - Private

        @ViewBuilder
        private var mainView: some View {
            if viewModel.isLoading {
                LoadingView()
            } else if viewModel.recipes.isEmpty {
                EmptyView(status: viewModel.hasSearched ? .result : .initial,
                          minCharactersCount: RecipesSearchViewModel.Constants.minCharactersCount)
            } else {
                ScrollView {
                    LazyVGrid(columns: RecipeItemView.numberOfColumns(for: horizontalSizeClass)) {
                        ForEach(viewModel.recipes) { item in
                            Button {
                                viewModel.showRecipe(id: item.id)
                            } label: {
                                RecipeItemView(item: item)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                }
                .scrollDismissesKeyboard(.immediately)
            }
        }
    }
}

#if DEBUG
#Preview {
    FRLib.RecipesSearchView(viewModel: .preview(query: "test"))
}
#endif
