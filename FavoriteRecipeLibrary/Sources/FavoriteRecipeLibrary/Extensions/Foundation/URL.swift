//
//  URL.swift
//  FavoriteRecipeLibrary
//
//  Created by Karachentsev Oleksandr on 17.08.2025.
//

import Foundation

extension URL {
    public init?(string raw: String?) {
        guard let raw, !raw.isEmpty else { return nil }
        self.init(string: raw)
    }
}
