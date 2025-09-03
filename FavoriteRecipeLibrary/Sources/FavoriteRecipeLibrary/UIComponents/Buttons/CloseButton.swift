//
//  CloseButton.swift
//  FavoriteRecipeLibrary
//
//  Created by Karachentsev Oleksandr on 30.08.2025.
//

import SwiftUI

public struct CloseButton: View {

    // MARK: - Properties

    let hasText: Bool
    let action: () -> Void

    // MARK: - Init / Deinit

    public init(hasText: Bool = true, action: @escaping () -> Void) {
        self.hasText = hasText
        self.action = action
    }

    // MARK: - Body

    public var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: "xmark")
                if hasText {
                    Text("Close")
                }
            }
        }
    }
}

#if DEBUG
#Preview {
    CloseButton(action: { })
}
#Preview {
    CloseButton(hasText: false, action: { })
}
#endif
