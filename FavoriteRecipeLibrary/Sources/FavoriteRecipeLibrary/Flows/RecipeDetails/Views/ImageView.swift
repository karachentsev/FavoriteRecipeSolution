//
//  ImageView.swift
//  FavoriteRecipeLibrary
//
//  Created by Karachentsev Oleksandr on 01.09.2025.
//

import SwiftUI
import Kingfisher

private enum Constants {
    static let imageMaxHeight: CGFloat = 300
    static let imageCornerRadius: CGFloat = 10
}

extension FRLib.RecipeDetailsView {
    struct ImageView: View {

        // MARK: - Properties

        let recipeDetails: FRLib.RecipeDetails
        let maxWidth: CGFloat
        @Binding var aspectRatio: CGFloat

        // MARK: - Body

        var body: some View {
            HStack(alignment: .center) {
                Spacer()

                if let name = recipeDetails.debugThumbName {
                    Image(name, bundle: .module)
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: maxWidth, maxHeight: Constants.imageMaxHeight)
                        .aspectRatio(aspectRatio, contentMode: .fit)
                        .cornerRadius(Constants.imageCornerRadius)
                } else {
                    KFImage(recipeDetails.thumbUrl)
                        .cacheOriginalImage()
                        .onFailureView {
                            Image(systemName: "photo.fill")
                                .resizable()
                                .scaledToFill()
                                .frame(maxWidth: maxWidth, maxHeight: Constants.imageMaxHeight)
                                .aspectRatio(aspectRatio, contentMode: .fit)
                                .cornerRadius(Constants.imageCornerRadius)
                        }
                        .onSuccess { result in
                            let size = result.image.size
                            aspectRatio = size.width / size.height
                        }
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: maxWidth, maxHeight: Constants.imageMaxHeight)
                        .aspectRatio(aspectRatio, contentMode: .fit)
                        .cornerRadius(Constants.imageCornerRadius)
                }

                Spacer()
            }
        }
    }
}

#if DEBUG
#Preview {
    FRLib.RecipeDetailsView.ImageView(recipeDetails: .preview, maxWidth: 200, aspectRatio: .constant(16 / 9))
}
#endif
