//
//  CustomError.swift
//  FavoriteRecipeLibrary
//
//  Created by Karachentsev Oleksandr on 17.08.2025.
//

import Foundation

extension FRLib {
    public enum CustomError: LocalizedError {
        case general
        case message(desc: String)
        case network(desc: String)
        case coreData(desc: String)

        public var errorDescription: String? {
            switch self {
            case .general:
                return "Something went wrong!"
            case .message(desc: let desc):
                return desc
            case .network(let desc):
                return desc
            case .coreData(let desc):
                return desc
            }
        }
    }
}
