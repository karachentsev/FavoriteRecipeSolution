//
//  NetworkService.swift
//  FavoriteRecipeLibrary
//
//  Created by Karachentsev Oleksandr on 29.07.2025.
//

import Foundation
import Alamofire

extension FRLib {

    // MARK: - NetworkServicing

    public protocol NetworkServicing: Sendable {
        func getCategories() async throws -> [Category]
        func getRecipes(categoryName: String) async throws -> [Recipe]
        func getRecipeDetails(id: String) async throws -> RecipeDetails
        func getRandomRecipeDetails() async throws -> RecipeDetails
    }

    // MARK: - NetworkService

    public final class NetworkService: NetworkServicing {

        // MARK: - Static properties

        public static let shared = NetworkService()

        // MARK: - Actions

        public func getCategories() async throws -> [Category] {
            return try await AF.request(ApiUrls.categories, method: .get)
                .validate()
                .serializingDecodable(CategoryResponse.self)
                .response
                .result.get().categories
        }

        public func getRecipes(categoryName: String) async throws -> [Recipe] {
            return try await AF.request(ApiUrls.recipes(categoryName: categoryName), method: .get)
                .validate()
                .serializingDecodable(RecipeResponse.self)
                .response
                .result.get().meals
        }

        public func getRecipeDetails(id: String) async throws -> RecipeDetails {
            let details = try await AF.request(ApiUrls.recipeDetails(id: id), method: .get)
                .validate()
                .serializingDecodable(RecipeDetailsResponse.self)
                .response
                .result.get().meals.first
            if let details {
                return details.recipeDetails
            } else {
                throw CustomError.network(desc: "No details for id: \(id)")
            }
        }

        public func getRandomRecipeDetails() async throws -> RecipeDetails {
            let details = try await AF.request(ApiUrls.randomRecipeDetails, method: .get)
                .validate()
                .serializingDecodable(RecipeDetailsResponse.self)
                .response
                .result.get().meals.first

            if let details {
                return details.recipeDetails
            } else {
                throw CustomError.network(desc: "No random details")
            }
        }
    }
}

extension FRLib.NetworkService {
    struct CategoryResponse: Decodable {
        let categories: [FRLib.Category]
    }

    struct RecipeResponse: Decodable {
        let meals: [FRLib.Recipe]
    }

    struct RecipeDetailsResponse: Decodable {

        // MARK: - Item

        struct Item: Decodable {

            // MARK: - Properties

            let idMeal: String
            let strMeal: String
            let strCategory: String
            let strArea: String
            let strInstructions: String
            let strMealThumb: URL
            var debugThumbName: String?
            let strTags: String?
            let strYoutube: String?
            let strIngredient1, strIngredient2, strIngredient3, strIngredient4, strIngredient5, strIngredient6: String?
            let strIngredient7, strIngredient8, strIngredient9, strIngredient10, strIngredient11, strIngredient12: String?
            let strIngredient13, strIngredient14, strIngredient15, strIngredient16, strIngredient17, strIngredient18: String?
            let strIngredient19, strIngredient20: String?
            let strMeasure1, strMeasure2, strMeasure3, strMeasure4, strMeasure5, strMeasure6, strMeasure7: String?
            let strMeasure8, strMeasure9, strMeasure10, strMeasure11, strMeasure12, strMeasure13, strMeasure14: String?
            let strMeasure15, strMeasure16, strMeasure17, strMeasure18, strMeasure19, strMeasure20: String?

            // MARK: - Getters properties

            var recipeDetails: FRLib.RecipeDetails {
                var ingredients = [FRLib.RecipeDetails.Ingredient]()
                if let strIngredient1, !strIngredient1.isEmpty, let strMeasure1, !strMeasure1.isEmpty {
                    ingredients.append(.init(name: strIngredient1, measure: strMeasure1))
                }
                if let strIngredient2, !strIngredient2.isEmpty, let strMeasure2, !strMeasure2.isEmpty {
                    ingredients.append(.init(name: strIngredient2, measure: strMeasure2))
                }
                if let strIngredient3, !strIngredient3.isEmpty, let strMeasure3, !strMeasure3.isEmpty {
                    ingredients.append(.init(name: strIngredient3, measure: strMeasure3))
                }
                if let strIngredient4, !strIngredient4.isEmpty, let strMeasure4, !strMeasure4.isEmpty {
                    ingredients.append(.init(name: strIngredient4, measure: strMeasure4))
                }
                if let strIngredient5, !strIngredient5.isEmpty, let strMeasure5, !strMeasure5.isEmpty {
                    ingredients.append(.init(name: strIngredient5, measure: strMeasure5))
                }
                if let strIngredient6, !strIngredient6.isEmpty, let strMeasure6, !strMeasure6.isEmpty {
                    ingredients.append(.init(name: strIngredient6, measure: strMeasure6))
                }
                if let strIngredient7, !strIngredient7.isEmpty, let strMeasure7, !strMeasure7.isEmpty {
                    ingredients.append(.init(name: strIngredient7, measure: strMeasure7))
                }
                if let strIngredient8, !strIngredient8.isEmpty, let strMeasure8, !strMeasure8.isEmpty {
                    ingredients.append(.init(name: strIngredient8, measure: strMeasure8))
                }
                if let strIngredient9, !strIngredient9.isEmpty, let strMeasure9, !strMeasure9.isEmpty {
                    ingredients.append(.init(name: strIngredient9, measure: strMeasure9))
                }
                if let strIngredient10, !strIngredient10.isEmpty, let strMeasure10, !strMeasure10.isEmpty {
                    ingredients.append(.init(name: strIngredient10, measure: strMeasure10))
                }
                if let strIngredient11, !strIngredient11.isEmpty, let strMeasure11, !strMeasure11.isEmpty {
                    ingredients.append(.init(name: strIngredient11, measure: strMeasure11))
                }
                if let strIngredient12, !strIngredient12.isEmpty, let strMeasure12, !strMeasure12.isEmpty {
                    ingredients.append(.init(name: strIngredient12, measure: strMeasure12))
                }
                if let strIngredient13, !strIngredient13.isEmpty, let strMeasure13, !strMeasure13.isEmpty {
                    ingredients.append(.init(name: strIngredient13, measure: strMeasure13))
                }
                if let strIngredient14, !strIngredient14.isEmpty, let strMeasure14, !strMeasure14.isEmpty {
                    ingredients.append(.init(name: strIngredient14, measure: strMeasure14))
                }
                if let strIngredient15, !strIngredient15.isEmpty, let strMeasure15, !strMeasure15.isEmpty {
                    ingredients.append(.init(name: strIngredient15, measure: strMeasure15))
                }
                if let strIngredient16, !strIngredient16.isEmpty, let strMeasure16, !strMeasure16.isEmpty {
                    ingredients.append(.init(name: strIngredient16, measure: strMeasure16))
                }
                if let strIngredient17, !strIngredient17.isEmpty, let strMeasure17, !strMeasure17.isEmpty {
                    ingredients.append(.init(name: strIngredient17, measure: strMeasure17))
                }
                if let strIngredient18, !strIngredient18.isEmpty, let strMeasure18, !strMeasure18.isEmpty {
                    ingredients.append(.init(name: strIngredient18, measure: strMeasure18))
                }
                if let strIngredient19, !strIngredient19.isEmpty, let strMeasure19, !strMeasure19.isEmpty {
                    ingredients.append(.init(name: strIngredient19, measure: strMeasure19))
                }
                if let strIngredient20, !strIngredient20.isEmpty, let strMeasure20, !strMeasure20.isEmpty {
                    ingredients.append(.init(name: strIngredient20, measure: strMeasure20))
                }
                return .init(id: idMeal, name: strMeal, categoryName: strCategory, area: strArea, instructions: strInstructions,
                             thumbUrl: strMealThumb, tags: strTags, youtubeUrl: URL(string: strYoutube),
                             ingredients: ingredients, isFavorite: false)
            }
        }

        // MARK: - Properties

        let meals: [Item]
    }
}
