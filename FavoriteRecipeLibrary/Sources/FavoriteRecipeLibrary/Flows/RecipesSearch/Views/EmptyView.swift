//
//  EmptyView.swift
//  FavoriteRecipeLibrary
//
//  Created by Karachentsev Oleksandr on 04.09.2025.
//

import SwiftUI

extension FRLib.RecipesSearchView {
    struct EmptyView: View {

        // MARK: - Status

        enum Status {
            case initial, result
        }

        // MARK: - Properties

        let status: Status
        let minCharactersCount: Int

        // MARK: - Getters properties

        private var systemName: String {
            switch status {
            case .initial: "magnifyingglass"
            case .result: "questionmark"
            }
        }

        private var title: String {
            switch status {
            case .initial: "Find your recipe"
            case .result: "No recipes found"
            }
        }

        private var desc: String {
            switch status {
            case .initial: "Please enter at least \(minCharactersCount) characters to start searching"
            case .result: "We couldn’t find any matches." + "\n" + "Try a different name or ingredient."
            }
        }

        // MARK: - Body

        var body: some View {
            VStack(spacing: 28) {
                Image(systemName: systemName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .foregroundStyle(Color.accentColor)
                    .shadow(radius: 6)

                Text(title)
                    .font(.title2.weight(.semibold))
                    .foregroundStyle(.primary)

                Text(desc)
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.secondary)
                    .padding(.horizontal, 40)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
        }
    }
}

#if DEBUG
#Preview {
    FRLib.RecipesSearchView.EmptyView(status: .initial, minCharactersCount: 2)
        .preferredColorScheme(.light)
}

#Preview {
    FRLib.RecipesSearchView.EmptyView(status: .initial, minCharactersCount: 2)
        .preferredColorScheme(.dark)
}

#Preview {
    FRLib.RecipesSearchView.EmptyView(status: .result, minCharactersCount: 2)
        .preferredColorScheme(.light)
}

#Preview {
    FRLib.RecipesSearchView.EmptyView(status: .result, minCharactersCount: 2)
        .preferredColorScheme(.dark)
}
#endif
