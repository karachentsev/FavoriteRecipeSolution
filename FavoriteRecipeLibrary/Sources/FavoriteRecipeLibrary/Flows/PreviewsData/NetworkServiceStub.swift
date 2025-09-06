//
//  NetworkServiceStub.swift
//  FavoriteRecipeLibrary
//
//  Created by Karachentsev Oleksandr on 29.07.2025.
//

import Foundation

#if DEBUG
struct NetworkServiceStub: FRLib.NetworkServicing {

    // MARK: - Properties

    var count = 10
    var hasError = false

    // MARK: - Actions

    func getCategories() async throws -> [FRLib.Category] {
        if hasError {
            throw FRLib.CustomError.network(desc: "Network error")
        }

        var result = [FRLib.Category]()
        for index in 0..<count {
            result.append(.makeRandomItem(for: index))
        }
        return result
    }

    func getRecipes(categoryName: String) async throws -> [FRLib.Recipe] {
        if hasError {
            throw FRLib.CustomError.network(desc: "Network error")
        }

        var result = [FRLib.Recipe]()
        for index in 0..<count {
            result.append(.makeRandomItem(for: index))
        }
        return result
    }

    func getRecipeDetails(id: String) async throws -> FRLib.RecipeDetails {
        if hasError {
            throw FRLib.CustomError.network(desc: "Network error")
        }

        return .preview
    }

    func getRandomRecipeDetails() async throws -> FRLib.RecipeDetails {
        if hasError {
            throw FRLib.CustomError.network(desc: "Network error")
        }

        return .preview
    }

    func searchRecipes(query: String) async throws -> [FRLib.RecipeDetails] {
        if hasError {
            throw FRLib.CustomError.network(desc: "Network error")
        }

        var result = [FRLib.RecipeDetails]()
        for index in 0..<count {
            result.append(.preview(id: String(index)))
        }
        return result
    }
}
#endif
