//
//  RecipesSearchView.swift
//  FavoriteRecipemacOS
//
//  Created by Karachentsev Oleksandr on 04.09.2025.
//

import SwiftUI
import FavoriteRecipeLibrary

struct RecipesSearchView: View {

    // MARK: - Properties

    @ObservedObject var viewModel: FRLib.RecipesSearchViewModel

    // MARK: - Body

    var body: some View {
        VStack {
            SearchBar(query: $viewModel.inputQuery, prompt: FRLib.RecipesSearchView.Constants.prompt)
            FRLib.RecipesSearchView(viewModel: viewModel)
        }
        .padding([.leading, .top, .trailing])
        .background(Color.defBackground)
    }
}

#if DEBUG
#Preview {
    RecipesSearchView(viewModel: .preview(query: "test"))
}

#Preview {
    RecipesSearchView(viewModel: .preview())
}
#endif
