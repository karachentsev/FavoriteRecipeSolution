//
//  RandomRecipeView.swift
//  FavoriteRecipeiOS
//
//  Created by Karachentsev Oleksandr on 30.08.2025.
//

import SwiftUI
import FavoriteRecipeLibrary

struct RandomRecipeView: View {

    // MARK: - Properties

    @ObservedObject var viewModel: FRLib.RecipeDetailsViewModel
    @State private var isAppeared = false

    // MARK: - Body

    var body: some View {
        NavigationView {
            FRLib.RecipeDetailsView(recipeDetails: viewModel.recipeDetails, isLoading: viewModel.isLoading,
                                    error: viewModel.error, youTubeAction: viewModel.showYouTube)
            .navigationBarTitle(viewModel.recipeDetails?.name ?? "Recipe")
            .navigationBarItems(leading: RandomButton {
                Task {
                    await viewModel.loadRandomData()
                }
            }, trailing: FavoriteButton(isFavorite: viewModel.isFavorite) {
                Task {
                    await viewModel.updateFavorite()
                }
            })
            .onAppear {
                guard !isAppeared else { return }
                isAppeared = true
                Task {
                    await viewModel.loadRandomData()
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}

#if DEBUG
#Preview {
    RandomRecipeView(viewModel: .preview())
}
#endif
