//
//  CategoryItemView.swift
//  FavoriteRecipeLibrary
//
//  Created by Karachentsev Oleksandr on 29.07.2025.
//

import SwiftUI
import Kingfisher

private enum Constants {
    static let imageHeight: CGFloat = 60
    static let imageWidth = imageHeight * 2
}

struct CategoryItemView: View {

    // MARK: - Properties

    let item: FRLib.Category

    // MARK: - Body

    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                if let name = item.debugThumbName {
                    Image(name, bundle: .module)
                        .resizable()
                        .scaledToFit()
                        .frame(width: Constants.imageWidth, height: Constants.imageHeight)
                } else {
                    KFImage(item.thumbUrl)
                        .cacheOriginalImage()
                        .onFailureView {
                            Image(systemName: "photo.fill")
                                .resizable()
                                .scaledToFit()
                        }
                        .resizable()
                        .scaledToFit()
                        .frame(width: Constants.imageWidth, height: Constants.imageHeight)
                }

                Text(item.name)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.secondary)
                    .font(.title3)
                    .italic()
                    .fontWeight(.semibold)
                    .lineLimit(2)
            }

            Text(item.desc)
                .multilineTextAlignment(.leading)
                .font(.body)
                .foregroundColor(.gray)
                .lineLimit(3)
        }
    }
}

#if DEBUG
#Preview {
    CategoryItemView(item: .makeRandomItem(for: 0))
        .frame(width: 400, height: 200)
}
#endif
