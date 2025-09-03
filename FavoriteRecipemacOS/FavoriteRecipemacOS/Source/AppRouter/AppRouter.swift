//
//  AppRouter.swift
//  FavoriteRecipemacOS
//
//  Created by Karachentsev Oleksandr on 29.07.2025.
//

import AppKit
import SwiftUI
import FavoriteRecipeLibrary

private enum Constants {
    static let windowSize = NSSize(width: 900, height: 600)
}

@MainActor
final class AppRouter {

    // MARK: - Static properties

    static let shared = AppRouter()

    // MARK: - Properties

    private var window: NSWindow!

    // MARK: - Init / Deinit

    private init() { }

    // MARK: - Setup

    func setup() {
        window = NSWindow(contentRect: NSRect(origin: .zero, size: Constants.windowSize),
                          styleMask: [.miniaturizable, .closable, .resizable, .titled],
                          backing: .buffered, defer: false)
        let viewController = ServiceAssembly.shared.makeRootViewController()
        viewController.view.frame.size = Constants.windowSize
        window.center()
        window.contentViewController = viewController
        window.makeKeyAndOrderFront(nil)
    }
}

extension AppRouter: FRLib.AppRouting {
    func showRecipeList(for category: FRLib.Category) {
        let viewController = ServiceAssembly.shared.makeRecipeListViewController(for: category)
        viewController.identifier = .init(category.id)
        window.present(viewController)
    }

    func closeRecipeList(for category: FRLib.Category) {
        let id = NSUserInterfaceItemIdentifier(category.id)
        window.dismissViewController(by: id)
    }

    func showRecipe(id: String) {
        let viewController = ServiceAssembly.shared.makeRecipeDetailsViewController(for: id)
        viewController.identifier = .init(id)
        window.present(viewController)
    }

    func closeRecipe(id: String) {
        let id = NSUserInterfaceItemIdentifier(id)
        window.dismissViewController(by: id)
    }

    func showYouTube(for url: URL) {
        let view = FullScreenWebView(url: url) { [weak self] in
            self?.closeYouTube(for: url)
        }
        let viewController = NSHostingController(rootView: view)
        viewController.identifier = .init(url.absoluteString)
        window.present(viewController)
    }

    func closeYouTube(for url: URL) {
        let id = NSUserInterfaceItemIdentifier(url.absoluteString)
        window.dismissViewController(by: id)
    }
}
