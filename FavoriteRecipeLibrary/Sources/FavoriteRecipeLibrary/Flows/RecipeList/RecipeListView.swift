//
//  RecipeListView.swift
//  FavoriteRecipeLibrary
//
//  Created by Karachentsev Oleksandr on 29.07.2025.
//

import SwiftUI

extension FRLib {
    public struct RecipeListView: View {

        // MARK: - Properties

        @ObservedObject var viewModel: RecipeListViewModel
        @Environment(\.horizontalSizeClass) private var horizontalSizeClass

        // MARK: - Init / Deinit

        public init(viewModel: RecipeListViewModel) {
            self.viewModel = viewModel
        }

        // MARK: - Body

        public var body: some View {
            mainView
                .onAppear {
                    Task {
                        await viewModel.fetchRecipes()
                    }
                }
        }

        // MARK: - Private

        @ViewBuilder
        private var mainView: some View {
            if viewModel.isLoading {
                LoadingView()
            } else {
                ScrollView {
                    VStack(alignment: .leading) {
                        Text(viewModel.category.desc)
                            .foregroundStyle(.secondary)

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
                }
                .padding([.leading, .trailing])
                .errorAlert($viewModel.error)
            }
        }
    }
}

#if DEBUG
#Preview {
    FRLib.RecipeListView(viewModel: .preview())
}
#endif
