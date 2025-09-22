//
//  CategoryListView.swift
//  FavoriteRecipeLibrary
//
//  Created by Karachentsev Oleksandr on 29.07.2025.
//

import SwiftUI

extension FRLib {
    public struct CategoryListView: View {

        // MARK: - Properties

        @ObservedObject var viewModel: CategoryListViewModel

        // MARK: - Init / Deinit

        public init(viewModel: CategoryListViewModel) {
            self.viewModel = viewModel
        }

        // MARK: - Body

        public var body: some View {
            mainView
                .onAppear {
                    guard viewModel.categories.isEmpty, !viewModel.isLoading else { return }
                    Task {
                        await viewModel.fetchCategories()
                    }
                }
        }

        // MARK: - Private

        @ViewBuilder
        public var mainView: some View {
            if viewModel.isLoading {
                LoadingView()
            } else {
                List {
                    ForEach(viewModel.categories) { item in
                        Button {
                            viewModel.showRecipeList(for: item)
                        } label: {
                            HStack {
                                CategoryItemView(item: item)
#if os(ios)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.gray)
#endif
                            }
                            .contentShape(Rectangle())
                        }
                        .buttonStyle(PlainButtonStyle())

                        Rectangle()
                            .fill(Color.gray.opacity(0.4))
                            .frame(height: 2)
                    }
                    .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                }
                .scrollContentBackground(.hidden)
                .errorAlert($viewModel.error)
            }
        }
    }
}

#if DEBUG
#Preview {
    let view = FRLib.CategoryListView(viewModel: .preview())
#if os(macOS)
    return view
        .frame(width: 600, height: 600)
#else
    return view
#endif
}
#endif

#if DEBUG
#Preview {
    let view = FRLib.CategoryListView(viewModel: .previewError())
#if os(macOS)
    return view
        .frame(width: 600, height: 600)
#else
    return view
#endif
}
#endif
