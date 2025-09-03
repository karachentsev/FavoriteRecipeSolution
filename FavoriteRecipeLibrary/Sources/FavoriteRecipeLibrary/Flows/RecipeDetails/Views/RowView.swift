//
//  RowView.swift
//  FavoriteRecipeLibrary
//
//  Created by Karachentsev Oleksandr on 03.09.2025.
//

import SwiftUI

struct RowView: View {

    // MARK: - Properties

    let title: String
    let value: String

    // MARK: - Body

    var body: some View {
        HStack {
            Text(title + ": ")
                .bold()
            Spacer()
            Text(value)
        }
    }
}

#if DEBUG
#Preview {
    RowView(title: "Title", value: "Description")
}
#endif
