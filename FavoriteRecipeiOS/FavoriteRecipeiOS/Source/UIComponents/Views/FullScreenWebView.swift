//
//  FullScreenWebView.swift
//  FavoriteRecipeiOS
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
        NavigationView {
            mainView
                .navigationBarTitle(url?.absoluteString ?? "Bad URL")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        CloseButton(hasText: false, action: onDismiss)
                    }
                }
        }
        .navigationViewStyle(.stack)
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
