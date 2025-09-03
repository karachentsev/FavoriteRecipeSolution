//
//  YouTubeButton.swift
//  FavoriteRecipeLibrary
//
//  Created by Karachentsev Oleksandr on 17.08.2025.
//

import SwiftUI

struct YouTubeButton: View {

    // MARK: - Properties

    var action: () -> Void

    // MARK: - Body

    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: "play.rectangle.fill")
                    .font(.title2)
                Text("Watch on YouTube")
                    .fontWeight(.semibold)
            }
            .foregroundColor(.white)
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(
                Capsule()
                    .fill(Color(red: 1.0, green: 0, blue: 0))
            )
        }
        .buttonStyle(PlainButtonStyle())
        .contentShape(Capsule())
        .background(Color.clear)
    }
}

#if DEBUG
#Preview {
    YouTubeButton(action: { })
}
#endif
