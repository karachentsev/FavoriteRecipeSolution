//
//  FullScreenWebView.swift
//  FavoriteRecipemacOS
//
//  Created by Karachentsev Oleksandr on 30.08.2025.
//

import SwiftUI
import FavoriteRecipeLibrary

struct FullScreenWebView: View {

    // MARK: - Properties

    let url: URL?
    let onDismiss: () -> Void

    // MARK: - Body

    var body: some View {
        VStack {
            ZStack {
                HStack {
                    CloseButton(action: onDismiss)
                    Spacer()
                }

                HStack {
                    Spacer()
                    Text(url?.absoluteString ?? "Bad URL")
                    Spacer()
                }
            }
            .padding([.leading, .top, .trailing])

            mainView
        }
        .background(Color.defBackground)
    }

    // MARK: - Private

    @ViewBuilder
    private var mainView: some View {
        if let url {
            WebView(url: url)
        } else {
            ErrorView(error: .message(desc: "No video"))
        }
    }
}

#if DEBUG
#Preview {
    FullScreenWebView(url: URL(string: "https://www.google.com")!, onDismiss: { })
}
#endif
