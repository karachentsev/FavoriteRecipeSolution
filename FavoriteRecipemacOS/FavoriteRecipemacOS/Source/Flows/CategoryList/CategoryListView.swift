//
//  CategoryListView.swift
//  FavoriteRecipemacOS
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
        VStack {
            TopBarView(title: "Categories") {
                Button {
                    Task {
                        await viewModel.fetchCategories()
                    }
                } label: {
                    Image(systemName: "arrow.clockwise")
                }
                .keyboardShortcut("r", modifiers: [.command])
                Spacer()
            }
            .padding([.leading, .top, .trailing])

            FRLib.CategoryListView(viewModel: viewModel)
        }
        .background(Color.defBackground)
    }
}

#if DEBUG
#Preview {
    CategoryListView(viewModel: .preview())
}
#endif
