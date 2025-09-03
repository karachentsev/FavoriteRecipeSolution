//
//  Recipe.swift
//  FavoriteRecipeLibrary
//
//  Created by Karachentsev Oleksandr on 29.07.2025.
//

import Foundation

extension FRLib {
    public struct Recipe: Decodable, Sendable, Identifiable, RecipeItemViewProtocol {

        // MARK: - Properties

        public let id: String
        public let name: String
        public let thumbUrl: URL
        public var debugThumbName: String?

        // MARK: - CodingKeys

        enum CodingKeys: String, CodingKey {
            case id = "idMeal"
            case name = "strMeal"
            case thumbUrl = "strMealThumb"
        }
    }
}

extension FRLib.Recipe {
    init(entity: RecipeDetailsEntity) {
        self.init(id: entity.id, name: entity.name, thumbUrl: entity.thumbUrl)
    }
}

#if DEBUG
extension FRLib.Recipe {
    static func makeRandomItem(for index: Int) -> FRLib.Recipe {
        if index % 3 == 0 {
            return .init(id: String(index), name: "Baked salmon with fennel & tomatoes",
                         thumbUrl: URL.temporaryDirectory, debugThumbName: "recipeBakedSalmon")
        } else if index % 2 == 0 {
            return .init(id: String(index), name: "Fish fofos",
                         thumbUrl: URL.temporaryDirectory, debugThumbName: "recipeFishFofos")
        } else {
            return .init(id: String(index), name: "Grilled Portuguese sardines",
                         thumbUrl: URL.temporaryDirectory, debugThumbName: "recipeGrilledPortugueseSardines")
        }
    }
}
#endif
