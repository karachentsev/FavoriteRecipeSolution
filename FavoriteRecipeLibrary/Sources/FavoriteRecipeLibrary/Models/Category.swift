//
//  Category.swift
//  FavoriteRecipeLibrary
//
//  Created by Karachentsev Oleksandr on 29.07.2025.
//

import Foundation

extension FRLib {
    public struct Category: Sendable, Identifiable, Decodable {

        // MARK: - Properties

        public let id: String
        public let name: String
        public let desc: String
        public let thumbUrl: URL
        public var debugThumbName: String?

        // MARK: - CodingKeys

        enum CodingKeys: String, CodingKey {
            case id = "idCategory"
            case name = "strCategory"
            case desc = "strCategoryDescription"
            case thumbUrl = "strCategoryThumb"
        }
    }
}

#if DEBUG
extension FRLib.Category {
    static func makeRandomItem(for index: Int) -> FRLib.Category {
        if index % 3 == 0 {
            return .init(id: String(index), name: "Dessert",
                         desc: "Dessert is a course that concludes a meal. The course usually consists of sweet foods, such as confections dishes or fruit, and possibly a beverage such as dessert wine or liqueur, however in the United States it may include coffee, cheeses, nuts, or other savory items regarded as a separate course elsewhere. In some parts of the world, such as much of central and western Africa, and most parts of China, there is no tradition of a dessert course to conclude a meal.\r\n\r\nThe term dessert can apply to many confections, such as biscuits, cakes, cookies, custards, gelatins, ice creams, pastries, pies, puddings, and sweet soups, and tarts. Fruit is also commonly found in dessert courses because of its naturally occurring sweetness. Some cultures sweeten foods that are more commonly savory to create desserts.",
                         thumbUrl: URL.temporaryDirectory, debugThumbName: "categoryDessert")
        } else if index % 2 == 0 {
            return .init(id: String(index), name: "Chicken",
                         desc: "Chicken is a type of domesticated fowl, a subspecies of the red junglefowl. It is one of the most common and widespread domestic animals, with a total population of more than 19 billion as of 2011.[1] Humans commonly keep chickens as a source of food (consuming both their meat and eggs) and, more rarely, as pets.",
                         thumbUrl: URL.temporaryDirectory, debugThumbName: "categoryChicken")
        } else {
            return .init(id: String(index), name: "Beef",
                         desc: "Beef is the culinary name for meat from cattle, particularly skeletal muscle.",
                         thumbUrl: URL.temporaryDirectory, debugThumbName: "categoryBeef")
        }
    }
}
#endif
