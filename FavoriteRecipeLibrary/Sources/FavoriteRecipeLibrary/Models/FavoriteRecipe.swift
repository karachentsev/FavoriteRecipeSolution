//
//  FavoriteRecipe.swift
//  FavoriteRecipeLibrary
//
//  Created by Karachentsev Oleksandr on 02.09.2025.
//

import Foundation

extension FRLib {
    public struct FavoriteRecipe: Hashable, Sendable, RecipeItemViewProtocol {
        public let id: String
        public let name: String
        public let categoryName: String
        public let area: String
        public let thumbUrl: URL
        public var debugThumbName: String?
    }
}

extension FRLib.FavoriteRecipe {
    init(entity: RecipeDetailsEntity) {
        self.init(id: entity.id, name: entity.name, categoryName: entity.categoryName,
                  area: entity.area, thumbUrl: entity.thumbUrl)
    }
}

#if DEBUG
extension FRLib.FavoriteRecipe {
    static func makeRandomItem(for index: Int) -> FRLib.FavoriteRecipe {
        if index % 3 == 0 {
            return .init(id: String(index), name: "Baked salmon with fennel & tomatoes",
                         categoryName: "One", area: "Ukraine",
                         thumbUrl: URL.temporaryDirectory, debugThumbName: "recipeBakedSalmon")
        } else if index % 2 == 0 {
            return .init(id: String(index), name: "Fish fofos",
                         categoryName: "Five", area: "Germany",
                         thumbUrl: URL.temporaryDirectory, debugThumbName: "recipeFishFofos")
        } else {
            return .init(id: String(index), name: "Grilled Portuguese sardines",
                         categoryName: "Ten", area: "France",
                         thumbUrl: URL.temporaryDirectory, debugThumbName: "recipeGrilledPortugueseSardines")
        }
    }
}
#endif
