//
//  FavoriteRecipeListView.swift
//  FavoriteRecipemacOS
//
//  Created by Karachentsev Oleksandr on 30.08.2025.
//

import SwiftUI
import FavoriteRecipeLibrary

struct FavoriteRecipeListView: View {

    // MARK: - Properties

    @ObservedObject var viewModel: FRLib.FavoriteRecipeListViewModel

    // MARK: - Body

    var body: some View {
        VStack {
            TopBarView(title: "Favorites") {
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
                .pickerStyle(.menu)
                .frame(maxWidth: 150)

                Spacer()

                Button("Clear all") {
                    Task {
                        await viewModel.clearAll()
                    }
                }
                .buttonStyle(.accessoryBar)
                .padding([.top, .bottom], 1)
                .padding([.leading, .trailing], 8)
                .foregroundColor(.red)
                .background(Color.red.opacity(0.3))
                .cornerRadius(4)
            }

            FRLib.FavoriteRecipeListView(viewModel: viewModel)
        }
        .padding([.leading, .top, .trailing])
        .background(Color.defBackground)
    }
}

#if DEBUG
#Preview {
    FavoriteRecipeListView(viewModel: .preview())
}
#endif
