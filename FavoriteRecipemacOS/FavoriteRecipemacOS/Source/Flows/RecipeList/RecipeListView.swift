//
//  RecipeListView.swift
//  FavoriteRecipemacOS
//
//  Created by Karachentsev Oleksandr on 30.07.2025.
//

import SwiftUI
import FavoriteRecipeLibrary

struct RecipeListView: View {

    // MARK: - Properties

    @ObservedObject var viewModel: RecipeListViewModel

    // MARK: - Body

    var body: some View {
        VStack {
            TopBarView(title: viewModel.recipeListViewModel.category.name) {
                CloseButton(action: viewModel.recipeListViewModel.close)
                Spacer()
            }
            .padding([.leading, .top])

            FRLib.RecipeListView(viewModel: viewModel.recipeListViewModel)
        }
        .background(Color.defBackground)
    }
}

#if DEBUG
#Preview {
    RecipeListView(viewModel: .init(recipeListViewModel: .preview()))
}
#endif
