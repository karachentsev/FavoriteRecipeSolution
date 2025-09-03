//
//  RecipeDetailsView.swift
//  FavoriteRecipeiOS
//
//  Created by Karachentsev Oleksandr on 17.08.2025.
//

import SwiftUI
import FavoriteRecipeLibrary

struct RecipeDetailsView: View {

    // MARK: - Properties

    @ObservedObject var viewModel: FRLib.RecipeDetailsViewModel

    // MARK: - Body

    var body: some View {
        NavigationStack {
            FRLib.RecipeDetailsView(recipeDetails: viewModel.recipeDetails, isLoading: viewModel.isLoading,
                                    error: viewModel.error, youTubeAction: viewModel.showYouTube)
            .navigationBarTitle(viewModel.recipeDetails?.name ?? "Recipe")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    CloseButton(hasText: false, action: viewModel.close)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    FavoriteButton(isFavorite: viewModel.isFavorite) {
                        Task {
                            await viewModel.updateFavorite()
                        }
                    }
                }
            }
            .onAppear {
                Task {
                    await viewModel.loadData()
                }
            }
        }
    }
}

#if DEBUG
#Preview {
    RecipeDetailsView(viewModel: .preview(id: "id"))
}
#endif
