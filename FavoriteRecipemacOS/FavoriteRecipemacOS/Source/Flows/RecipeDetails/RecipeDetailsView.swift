//
//  RecipeDetailsView.swift
//  FavoriteRecipemacOS
//
//  Created by Karachentsev Oleksandr on 28.08.2025.
//

import SwiftUI
import FavoriteRecipeLibrary

struct RecipeDetailsView: View {

    // MARK: - Properties

    @ObservedObject var viewModel: FRLib.RecipeDetailsViewModel

    // MARK: - Body

    var body: some View {
        VStack {
            TopBarView(title: viewModel.recipeDetails?.name ?? "Recipe") {
                CloseButton(action: viewModel.close)
                    .keyboardShortcut("w", modifiers: [.command])
                Spacer()
                FavoriteButton(isFavorite: viewModel.isFavorite) {
                    Task {
                        await viewModel.updateFavorite()
                    }
                }
                .keyboardShortcut("f", modifiers: [.command])
            }
            .padding([.leading, .top, .trailing])

            FRLib.RecipeDetailsView(recipeDetails: viewModel.recipeDetails, isLoading: viewModel.isLoading,
                                    error: viewModel.error, youTubeAction: viewModel.showYouTube)
        }
        .background(Color.defBackground)
        .onAppear {
            Task {
                await viewModel.loadData()
            }
        }
    }
}

#if DEBUG
#Preview {
    RecipeDetailsView(viewModel: .preview(id: "id"))
}
#endif
