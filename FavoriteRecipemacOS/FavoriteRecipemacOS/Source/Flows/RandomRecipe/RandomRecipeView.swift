//
//  RandomRecipeView.swift
//  FavoriteRecipemacOS
//
//  Created by Karachentsev Oleksandr on 30.08.2025.
//

import SwiftUI
import FavoriteRecipeLibrary

struct RandomRecipeView: View {

    // MARK: - Properties

    @ObservedObject var viewModel: FRLib.RecipeDetailsViewModel
    @State private var hasAppeared = false

    // MARK: - Body

    var body: some View {
        VStack {
            TopBarView(title: "Random recipe: \(viewModel.recipeDetails?.name ?? "-")") {
                RandomButton {
                    Task {
                        await viewModel.loadRandomData()
                    }
                }
                .keyboardShortcut("r", modifiers: [.command])
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
            guard !hasAppeared else { return }
            hasAppeared = true
            Task {
                await viewModel.loadRandomData()
            }
        }
    }
}

#if DEBUG
#Preview {
    RandomRecipeView(viewModel: .preview())
}
#endif
