//
//  FavoriteButton.swift
//  FavoriteRecipeLibrary
//
//  Created by Karachentsev Oleksandr on 31.08.2025.
//

import SwiftUI

public struct FavoriteButton: View {

    // MARK: - Properties

    let isFavorite: Bool
    let action: () -> Void

    // MARK: - Init / Deinit

    public init(isFavorite: Bool, action: @escaping () -> Void) {
        self.isFavorite = isFavorite
        self.action = action
    }

    // MARK: - Body

    public var body: some View {
        Button(action: action) {
            Image(systemName: isFavorite ? "star.fill" : "star")
        }
    }
}

#if DEBUG
#Preview {
    FavoriteButton(isFavorite: true, action: { })
}
#Preview {
    FavoriteButton(isFavorite: false, action: { })
}
#endif
