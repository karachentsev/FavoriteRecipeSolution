//
//  RandomButton.swift
//  FavoriteRecipeLibrary
//
//  Created by Karachentsev Oleksandr on 31.08.2025.
//

import SwiftUI

public struct RandomButton: View {

    // MARK: - Properties

    let action: () -> Void

    // MARK: - Init / Deinit

    public init(action: @escaping () -> Void) {
        self.action = action
    }

    // MARK: - Body

    public var body: some View {
        Button("Next", action: action)
    }
}

#if DEBUG
#Preview {
    RandomButton(action: { })
}
#endif
