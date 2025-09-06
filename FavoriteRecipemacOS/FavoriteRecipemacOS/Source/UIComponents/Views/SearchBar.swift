//
//  SearchBar.swift
//  FavoriteRecipemacOS
//
//  Created by Karachentsev Oleksandr on 04.09.2025.
//

import SwiftUI

private enum Constants {
    static let cornerRadius: CGFloat = 12
}

struct SearchBar: View {

    // MARK: - Properties

    @Binding var query: String
    let prompt: String

    // MARK: - Body

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.secondary)

            TextField(prompt, text: $query)
                .textFieldStyle(.plain)
                .disableAutocorrection(true)

            if !query.isEmpty {
                Button("Cancel") {
                    query = ""
                }
                .buttonStyle(PlainButtonStyle())
                .foregroundStyle(Color.accentColor)
            }
        }
        .padding(8)
        .background(
            RoundedRectangle(cornerRadius: Constants.cornerRadius)
                .fill(.gray.opacity(0.3))
        )
        .overlay(
            RoundedRectangle(cornerRadius: Constants.cornerRadius)
                .stroke(.gray, lineWidth: 0.5)
        )
    }
}

#if DEBUG
#Preview {
    Group {
        SearchBar(query: .constant(""), prompt: "Search recipes...")
        SearchBar(query: .constant("test"), prompt: "Search recipes...")
    }
    .padding()
    .preferredColorScheme(.light)
}

#Preview {
    Group {
        SearchBar(query: .constant(""), prompt: "Search recipes...")
        SearchBar(query: .constant("test"), prompt: "Search recipes...")
    }
    .padding()
    .preferredColorScheme(.dark)
}
#endif
