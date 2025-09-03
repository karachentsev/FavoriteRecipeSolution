//
//  ErrorView.swift
//  FavoriteRecipeLibrary
//
//  Created by Karachentsev Oleksandr on 17.08.2025.
//

import SwiftUI

public struct ErrorView: View {

    // MARK: - Properties

    let error: FRLib.CustomError?

    // MARK: - Init / Deinit

    public init(error: FRLib.CustomError?) {
        self.error = error
    }

    // MARK: - Body

    public var body: some View {
        HStack {
            Spacer()
            if let text = error?.localizedDescription {
                Text("Error: \(text)")
            } else {
                Text("Something went wrong :-(")
            }
            Spacer()
        }
    }
}

#if DEBUG
#Preview {
    ErrorView(error: .general)
}
#Preview {
    ErrorView(error: nil)
}
#endif
