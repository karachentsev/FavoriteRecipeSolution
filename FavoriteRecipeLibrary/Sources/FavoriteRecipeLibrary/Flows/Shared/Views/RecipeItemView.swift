//
//  RecipeItemView.swift
//  FavoriteRecipeLibrary
//
//  Created by Karachentsev Oleksandr on 30.07.2025.
//

import SwiftUI
import Kingfisher

protocol RecipeItemViewProtocol {
    var id: String { get }
    var name: String { get }
    var thumbUrl: URL { get }
    var debugThumbName: String? { get }
}

struct RecipeItemView: View {

    // MARK: - Constants

    enum Constants {
        static let cornerRadius: CGFloat = 4
        static let transparentBackground = Color.black.opacity(0.3)
        static let padding: CGFloat = 4
    }

    // MARK: - Properties

    let item: RecipeItemViewProtocol

    // MARK: - Body

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            if let name = item.debugThumbName {
                Image(name, bundle: .module)
                    .resizable()
                    .scaledToFill()
            } else {
                KFImage(item.thumbUrl)
                    .cacheOriginalImage()
                    .onFailureView {
                        Image(systemName: "photo.fill")
                            .resizable()
                            .scaledToFit()
                    }
                    .resizable()
                    .scaledToFill()
            }

            Text(item.name)
                .font(.footnote)
                .padding(Constants.padding)
                .foregroundStyle(.white)
                .background(Constants.transparentBackground)
                .cornerRadius(Constants.cornerRadius)
        }
        .cornerRadius(Constants.cornerRadius)
    }
}

extension RecipeItemView {
    static func numberOfColumns(for horizontalSizeClass: UserInterfaceSizeClass?) -> [GridItem] {
        if horizontalSizeClass == .regular {
            return [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
        } else {
            return [GridItem(.flexible()), GridItem(.flexible())]
        }
    }
}
