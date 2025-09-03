// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FavoriteRecipeLibrary",
    platforms: [
        .iOS(.v18),
        .macOS(.v15)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "FavoriteRecipeLibrary",
            targets: ["FavoriteRecipeLibrary"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire.git", exact: "5.10.2"),
        .package(url: "https://github.com/onevcat/Kingfisher.git", exact: "8.5.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "FavoriteRecipeLibrary",
            dependencies: ["Alamofire", "Kingfisher"],
            path: "Sources/FavoriteRecipeLibrary",
            resources: [
                .process("FavoriteRecipe.xcdatamodeld"),
                .process("Resources/PreviewAssets.xcassets")
            ]
        ),
        .testTarget(
            name: "FavoriteRecipeLibraryTests",
            dependencies: ["FavoriteRecipeLibrary"]
        ),
    ]
)
