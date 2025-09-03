//
//  TopBarView.swift
//  FavoriteRecipemacOS
//
//  Created by Karachentsev Oleksandr on 31.08.2025.
//

import SwiftUI

struct TopBarView<Content>: View where Content: View {

    // MARK: - Properties

    let title: String
    @ViewBuilder let content: () -> Content

    // MARK: - Body

    var body: some View {
        ZStack {
            HStack(content: content)

            HStack {
                Spacer()
                Text(title)
                    .font(.title2)
                Spacer()
            }
        }
    }
}
