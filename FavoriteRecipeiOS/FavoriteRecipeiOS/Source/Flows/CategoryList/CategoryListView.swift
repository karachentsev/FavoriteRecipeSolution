//
//  CategoryListView.swift
//  FavoriteRecipeiOS
//
//  Created by Karachentsev Oleksandr on 01.09.2025.
//

import SwiftUI
import FavoriteRecipeLibrary

struct CategoryListView: View {

    // MARK: - Properties

    @ObservedObject var viewModel: FRLib.CategoryListViewModel

    // MARK: - Body

    var body: some View {
        NavigationView {
            FRLib.CategoryListView(viewModel: viewModel)
                .navigationTitle("Categories")
                .refreshable {
                    Task {
                        await viewModel.fetchCategories()
                    }
                }
        }
        .navigationViewStyle(.stack)
    }
}

#if DEBUG
#Preview {
    CategoryListView(viewModel: .preview())
}
#endif
