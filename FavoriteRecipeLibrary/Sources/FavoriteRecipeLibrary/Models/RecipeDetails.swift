//
//  RecipeDetails.swift
//  FavoriteRecipeLibrary
//
//  Created by Karachentsev Oleksandr on 17.08.2025.
//

import Foundation

extension FRLib {
    public struct RecipeDetails: Sendable {

        // MARK: - Properties

        public let id: String
        public let name: String
        public let categoryName: String
        public let area: String
        public let instructions: String
        public let thumbUrl: URL
        public var debugThumbName: String?
        public let tags: String?
        public let youtubeUrl: URL?
        public let ingredients: [Ingredient]?
        public var isFavorite: Bool
    }
}

extension FRLib.RecipeDetails {
    public struct Ingredient: Equatable, Codable, Sendable, Identifiable {

        // MARK: - Properties

        public var id = UUID()
        public let name: String
        public let measure: String
    }
}

extension FRLib.RecipeDetails {
    init(entity: RecipeDetailsEntity) {
        self.init(id: entity.id, name: entity.name, categoryName: entity.categoryName, area: entity.area,
                  instructions: entity.instructions, thumbUrl: entity.thumbUrl, tags: entity.tags,
                  youtubeUrl: entity.youtubeUrl, ingredients: entity.ingredients, isFavorite: entity.isFavorite)
    }
}

#if DEBUG
extension FRLib.RecipeDetails {
    static let preview = FRLib.RecipeDetails(id: "52819", name: "Cajun spiced fish tacos", categoryName: "Seafood", area: "Mexican",
                                             instructions: """
                                           Cooking in a cajun spice and cayenne pepper marinade makes this fish super succulent and flavoursome. Top with a zesty dressing and serve in a tortilla for a quick, fuss-free main that's delightfully summery.\r\n\r\nOn a large plate, mix the cajun spice and cayenne pepper with a little seasoning and use to coat the fish all over.\r\n\r\nHeat a little oil in a frying pan, add in the fish and cook over a medium heat until golden. Reduce the heat and continue frying until the fish is cooked through, about 10 minutes. Cook in batches if you don’t have enough room in the pan.\r\n\r\nMeanwhile, prepare the dressing by combining all the ingredients with a little seasoning.\r\nSoften the tortillas by heating in the microwave for 5-10 seconds. Pile high with the avocado, lettuce and spring onion, add a spoonful of salsa, top with large flakes of fish and drizzle over the dressing.
                                           """,
                                             thumbUrl: URL.temporaryDirectory, debugThumbName: "tacosRecipeDetails",
                                             tags: "Spicy,Fish", youtubeUrl: URL.temporaryDirectory,
                                             ingredients: Ingredient.previews, isFavorite: true)
}

extension FRLib.RecipeDetails.Ingredient {
    static let previews: [FRLib.RecipeDetails.Ingredient] = [
        .init(name: "Olive Oil", measure: "1 tbsp"), .init(name: "Red Chilli", measure: "1 finely sliced"),
        .init(name: "Thai red curry paste", measure: "2 ½ tbsp"), .init(name: "vegetable stock cube", measure: "1"),
        .init(name: "coconut milk", measure: "400ml can"), .init(name: "fish sauce", measure: "2 tsp"),
        .init(name: "rice noodles", measure: "100g"), .init(name: "lime", measure: "2 juice of 1, the other halved"),
        .init(name: "king prawns", measure: "150g"), .init(name: "coriander", measure: "½ small pack")
    ]
}
#endif
