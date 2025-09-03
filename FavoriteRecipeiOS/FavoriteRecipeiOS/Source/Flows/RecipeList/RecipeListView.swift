//
//  RecipeListView.swift
//  FavoriteRecipeiOS
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
        NavigationStack {
            FRLib.RecipeListView(viewModel: viewModel.recipeListViewModel)
                .navigationBarTitle(viewModel.recipeListViewModel.category.name)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: viewModel.recipeListViewModel.close) {
                            HStack {
                                Image(systemName: "chevron.left")
                                Text("Back")
                            }
                        }
                    }
                }
        }
    }
}

#if DEBUG
#Preview {
    RecipeListView(viewModel: .init(recipeListViewModel: .preview()))
}
#endif
