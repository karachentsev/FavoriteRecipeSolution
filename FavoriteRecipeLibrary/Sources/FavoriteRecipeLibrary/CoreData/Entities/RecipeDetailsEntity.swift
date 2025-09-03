//
//  RecipeDetailsEntity.swift
//  FavoriteRecipeLibrary
//
//  Created by Karachentsev Oleksandr on 17.08.2025.
//

import CoreData

// MARK: - RecipeDetailsEntity

@objc(RecipeDetailsEntity)
public final class RecipeDetailsEntity: NSManagedObject {

    // MARK: - Properties

    @NSManaged var id: String
    @NSManaged var name: String
    @NSManaged var categoryName: String
    @NSManaged var area: String
    @NSManaged var instructions: String
    @NSManaged var thumbUrl: URL
    @NSManaged var tags: String?
    @NSManaged var youtubeUrl: URL?
    @NSManaged var isFavorite: Bool

    var ingredients: [FRLib.RecipeDetails.Ingredient]? {
        get { primitiveValue(forKey: "ingredients") as? [FRLib.RecipeDetails.Ingredient] }
        set { setPrimitiveValue(newValue, forKey: "ingredients") }
    }
}

extension RecipeDetailsEntity: Entity {
    static var primaryKey: String { #keyPath(id) }
}

// MARK: - IngredientArrayTransformer

@objc(IngredientArrayTransformer)
final class IngredientArrayTransformer: ValueTransformer {
    override class func allowsReverseTransformation() -> Bool { true }
    override class func transformedValueClass() -> AnyClass { NSData.self }

    override func transformedValue(_ value: Any?) -> Any? {
        guard let ingredients = value as? [FRLib.RecipeDetails.Ingredient] else { return nil }
        return try? JSONEncoder().encode(ingredients)
    }

    override func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let data = value as? Data else { return nil }
        return try? JSONDecoder().decode([FRLib.RecipeDetails.Ingredient].self, from: data)
    }
}
