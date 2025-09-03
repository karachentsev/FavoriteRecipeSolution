//
//  IngredientsView.swift
//  FavoriteRecipeLibrary
//
//  Created by Karachentsev Oleksandr on 01.09.2025.
//

import SwiftUI

private enum Constants {
    static let columns = [GridItem(.flexible()), GridItem(.flexible())]
}

extension FRLib.RecipeDetailsView {
    struct IngredientsView: View {

        // MARK: - Properties

        let ingredients: [FRLib.RecipeDetails.Ingredient]
        let spacing: CGFloat

        // MARK: - Body

        var body: some View {
            VStack(spacing: spacing) {
                Text("Ingredients")
                    .font(.headline)
                    .bold()

                LazyVGrid(columns: Constants.columns, spacing: spacing) {
                    ForEach(ingredients) { ingredient in
                        Text(ingredient.name)
                            .font(.body)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        Text(ingredient.measure)
                            .font(.body.weight(.semibold))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                .frame(maxWidth: 400)
            }
            .padding(8)
            .background {
                RoundedRectangle(cornerSize: CGSize(width: 4, height: 4))
                    .fill(Color.gray.opacity(0.2))
            }
        }
    }
}

#if DEBUG
#Preview {
    FRLib.RecipeDetailsView.IngredientsView(ingredients: FRLib.RecipeDetails.Ingredient.previews, spacing: 12)
        .frame(width: 400, height: 400)
}
#endif
