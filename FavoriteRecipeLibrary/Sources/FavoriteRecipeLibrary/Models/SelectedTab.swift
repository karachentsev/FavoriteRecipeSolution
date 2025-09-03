//
//  SelectedTab.swift
//  FavoriteRecipeLibrary
//
//  Created by Karachentsev Oleksandr on 02.09.2025.
//

import Foundation

extension FRLib {
    public enum SelectedTab: String, CaseIterable, Identifiable {

        // MARK: - Cases

        case categories
        case random
        case favorites

        // MARK: - Getters properties

        public var systemName: String {
            switch self {
            case .categories:
                return "list.bullet"
            case .random:
                return "wand.and.stars"
            case .favorites:
                return "star"
            }
        }

        public var title: String {
            switch self {
            case .categories:
                return "Categories"
            case .random:
                return "Random"
            case .favorites:
                return "Favorites"
            }
        }

        public var id: String { self.rawValue }
    }
}
