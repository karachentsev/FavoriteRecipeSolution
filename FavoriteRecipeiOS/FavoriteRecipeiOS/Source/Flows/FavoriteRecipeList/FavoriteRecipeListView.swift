//
//  FavoriteRecipeListView.swift
//  FavoriteRecipeiOS
//
//  Created by Karachentsev Oleksandr on 30.08.2025.
//

import SwiftUI
import FavoriteRecipeLibrary

private enum Constants {
    static let toolbarHeight: CGFloat = 30
}

struct FavoriteRecipeListView: View {

    // MARK: - Properties

    @ObservedObject var viewModel: FRLib.FavoriteRecipeListViewModel

    // MARK: - Body

    var body: some View {
        NavigationView {
            FRLib.FavoriteRecipeListView(viewModel: viewModel)
                .padding([.leading, .trailing])
                .navigationBarTitle("Favorites")
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Picker("Sort by", selection: .init(get: {
                            viewModel.sortedBy
                        }, set: { item in
                            Task {
                                await viewModel.changeSorting(to: item)
                            }
                        })) {
                            ForEach(FRLib.StoragePublishService.SortedBy.allCases) {
                                Text($0.title).tag($0)
                            }
                        }
                        .pickerStyle(.navigationLink)
                        .frame(height: Constants.toolbarHeight)
                    }

                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Clear all") {
                            Task {
                                await viewModel.clearAll()
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                        .padding()
                        .foregroundColor(.red)
                        .frame(height: Constants.toolbarHeight)
                    }
                }
        }
        .navigationViewStyle(.stack)
    }
}

#if DEBUG
#Preview {
    FavoriteRecipeListView(viewModel: .preview())
}
#endif
