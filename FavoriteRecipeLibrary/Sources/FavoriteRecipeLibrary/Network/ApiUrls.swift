//
//  ApiUrls.swift
//  FavoriteRecipeLibrary
//
//  Created by Karachentsev Oleksandr on 29.07.2025.
//

import Foundation

enum ApiUrls {

    // MARK: - Api

    static var categories: String { makeUrlStr(path: "categories") }
    static func recipes(categoryName: String) -> String { makeUrlStr(path: "filter", queryItems: ["c": categoryName]) }
    static func recipeDetails(id: String) -> String { makeUrlStr(path: "lookup", queryItems: ["i": id]) }
    static var randomRecipeDetails: String { makeUrlStr(path: "random") }
    static func search(query: String) -> String { makeUrlStr(path: "search", queryItems: ["s": query]) }

    // MARK: - Private

    private static func makeUrlStr(path: String, queryItems: [String: String]? = nil) -> String {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "www.themealdb.com"
        components.path = "/api/json/v1/1/" + path + ".php"
        if let queryItems {
            var query = [URLQueryItem]()
            for (key, value) in queryItems {
                query.append(.init(name: key, value: value))
            }
            components.queryItems = query
        }
        return components.string ?? ""
    }
}

