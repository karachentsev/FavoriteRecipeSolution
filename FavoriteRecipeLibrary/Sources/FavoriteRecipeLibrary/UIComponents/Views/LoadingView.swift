//
//  LoadingView.swift
//  FavoriteRecipeLibrary
//
//  Created by Karachentsev Oleksandr on 29.07.2025.
//

import SwiftUI

struct LoadingView: View {

    // MARK: - Body

    var body: some View {
        VStack {
            Spacer()
            HStack(alignment: .center) {
                Spacer()
                Text("loading...")
                Spacer()
            }
            Spacer()
        }
    }
}

#if DEBUG
#Preview {
    LoadingView()
}
#endif
