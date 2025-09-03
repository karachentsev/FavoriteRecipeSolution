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
    static let toolbarCornerRadius: CGFloat = 6
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
                    .background {
                        RoundedRectangle(cornerRadius: Constants.toolbarCornerRadius)
                            .fill(Color.gray.opacity(0.3))
                    }

                    Button("Clear all") {
                        Task {
                            await viewModel.clearAll()
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding([.leading, .trailing], 8)
                    .foregroundColor(.red)
                    .frame(height: Constants.toolbarHeight)
                    .background {
                        RoundedRectangle(cornerRadius: Constants.toolbarCornerRadius)
                            .fill(Color.red.opacity(0.3))
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
