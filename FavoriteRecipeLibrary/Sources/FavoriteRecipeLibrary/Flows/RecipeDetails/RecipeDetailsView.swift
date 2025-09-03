//
//  RecipeDetailsView.swift
//  FavoriteRecipeLibrary
//
//  Created by Karachentsev Oleksandr on 17.08.2025.
//

import SwiftUI

private enum Constants {
    static let spacing: CGFloat = 16
}

extension FRLib {
    public struct RecipeDetailsView: View {

        // MARK: - Properties

        private let recipeDetails: FRLib.RecipeDetails?
        private let isLoading: Bool
        private let error: CustomError?
        private let youTubeAction: () -> Void
        @State private var aspectRatio: CGFloat = 16 / 9

        // MARK: - Init / Deinit

        public init(recipeDetails: FRLib.RecipeDetails?, isLoading: Bool, error: CustomError?,
                    youTubeAction: @escaping () -> Void) {
            self.recipeDetails = recipeDetails
            self.isLoading = isLoading
            self.error = error
            self.youTubeAction = youTubeAction
        }

        // MARK: - Body

        public var body: some View {
            if let recipeDetails {
                mainView(recipeDetails)
            } else if isLoading {
                LoadingView()
            } else {
                ErrorView(error: error)
            }
        }

        // MARK: - Private

        private func mainView(_ recipeDetails: FRLib.RecipeDetails) -> some View {
            GeometryReader { geometryReader in
                ScrollView {
                    VStack(alignment: .leading, spacing: Constants.spacing) {
                        ImageView(recipeDetails: recipeDetails, maxWidth: geometryReader.size.width, aspectRatio: $aspectRatio)

                        RowView(title: "Category", value: recipeDetails.categoryName)

                        RowView(title: "Area", value: recipeDetails.area)

                        if let tags = recipeDetails.tags {
                            RowView(title: "Tagline", value: tags)
                        }

                        VStack(alignment: .leading, spacing: Constants.spacing) {
                            Text("Instructions: ")
                                .bold()
                            Text(recipeDetails.instructions)
                        }

                        if let ingredients = recipeDetails.ingredients {
                            HStack(spacing: 0) {
                                Spacer(minLength: 0)
                                IngredientsView(ingredients: ingredients, spacing: Constants.spacing)
                                Spacer(minLength: 0)
                            }
                        }

                        if recipeDetails.youtubeUrl != nil {
                            HStack {
                                Spacer()
                                YouTubeButton(action: youTubeAction)
                                Spacer()
                            }
                        }
                    }
                }
            }
            .padding()
            .frame(maxWidth: 800)
        }
    }
}

#if DEBUG
#Preview {
    FRLib.RecipeDetailsView(recipeDetails: .preview, isLoading: false, error: nil, youTubeAction: { })
}
#Preview {
    FRLib.RecipeDetailsView(recipeDetails: nil, isLoading: true, error: nil, youTubeAction: { })
}
#Preview {
    FRLib.RecipeDetailsView(recipeDetails: nil, isLoading: false, error: .general, youTubeAction: { })
}
#endif
