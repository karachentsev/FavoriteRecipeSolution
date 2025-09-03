//
//  FavoriteRecipeListView.swift
//  FavoriteRecipeLibrary
//
//  Created by Karachentsev Oleksandr on 30.08.2025.
//

import SwiftUI

extension FRLib {
    public struct FavoriteRecipeListView: View {

        // MARK: - Properties

        @ObservedObject var viewModel: FavoriteRecipeListViewModel
        @Environment(\.horizontalSizeClass) private var horizontalSizeClass

        // MARK: - Init / Deinit

        public init(viewModel: FavoriteRecipeListViewModel) {
            self.viewModel = viewModel
        }

        // MARK: - Body

        public var body: some View {
            ScrollView {
                LazyVGrid(columns: RecipeItemView.numberOfColumns(for: horizontalSizeClass)) {
                    ForEach(viewModel.sectionedRecipes, id: \.self) { sectioned in
                        Section {
                            ForEach(sectioned, id: \.self) { item in
                                cell(for: item)
                            }
                        } header: {
                            if viewModel.sortedBy != .name, let item = sectioned.first, let title = title(for: item) {
                                HStack {
                                    Spacer()
                                    Text(title)
                                        .font(.title3)
                                        .foregroundColor(.primary)
                                        .italic()
                                        .padding([.top, .bottom], RecipeItemView.Constants.padding)
                                    Spacer()
                                }
                                .background(Color.accentColor.opacity(0.2))
                                .cornerRadius(RecipeItemView.Constants.cornerRadius)
                            }
                        }
                    }
                }
            }
        }

        // MARK: - Private

        private func cell(for item: FavoriteRecipe) -> some View {
            Button {
                viewModel.showRecipe(id: item.id)
            } label: {
                ZStack(alignment: .topTrailing) {
                    RecipeItemView(item: item)
                    Button(action: {
                        Task {
                            await viewModel.removeFromFavorite(id: item.id)
                        }
                    }) {
                        Image(systemName: "trash")
                            .padding(RecipeItemView.Constants.padding)
                            .foregroundStyle(Color.red)
                            .bold()
                            .background(RecipeItemView.Constants.transparentBackground)
                            .cornerRadius(RecipeItemView.Constants.cornerRadius)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .buttonStyle(PlainButtonStyle())
        }

        private func title(for item: FavoriteRecipe) -> String? {
            switch viewModel.sortedBy {
            case .name:
                return nil
            case .categoryName:
                return item.categoryName
            case .area:
                return item.area
            }
        }
    }
}

#if DEBUG
#Preview {
    let view = FRLib.FavoriteRecipeListView(viewModel: .preview())
#if os(macOS)
    return view
        .frame(width: 600, height: 600)
#else
    return view
#endif
}
#endif
