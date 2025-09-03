//
//  Entity.swift
//  FavoriteRecipeLibrary
//
//  Created by Karachentsev Oleksandr on 17.08.2025.
//

import Foundation

protocol Entity: AnyObject {
    static var primaryKey: String { get }
}
