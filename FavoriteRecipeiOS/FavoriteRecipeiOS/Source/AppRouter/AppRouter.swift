//
//  AppRouter.swift
//  FavoriteRecipeiOS
//
//  Created by Karachentsev Oleksandr on 29.07.2025.
//

import UIKit
import SwiftUI
import FavoriteRecipeLibrary

@MainActor
final class AppRouter {

    // MARK: - Static properties

    static let shared = AppRouter()

    // MARK: - Properties

    private var window: UIWindow!
    private var navigationController: RootNavigationController!

    // MARK: - Init / Deinit

    private init() { }

    // MARK: - Setup

    func setup(with scene: UIWindowScene) {
        window = UIWindow(windowScene: scene)
        navigationController = RootNavigationController(rootViewController: ServiceAssembly.shared.makeRootViewController())
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }

    // MARK: - Private

    private func findViewControllerToPresent() -> UIViewController {
        var viewController = findTopViewController(withRootViewController: navigationController)

        while let presentedViewController = viewController.presentedViewController {
            viewController = findTopViewController(withRootViewController: presentedViewController)
        }

        return viewController
    }

    private func findTopViewController(withRootViewController viewController: UIViewController) -> UIViewController {
        if let tabBarController = viewController as? UITabBarController,
           let selectedViewController = tabBarController.selectedViewController {
            return findTopViewController(withRootViewController: selectedViewController)
        } else if let navigationController = viewController as? UINavigationController,
                  let topViewController = navigationController.topViewController {
            return findTopViewController(withRootViewController: topViewController)
        } else {
            return viewController
        }
    }
}

extension AppRouter: FRLib.AppRouting {
    func showRecipeList(for category: FRLib.Category) {
        let viewController = ServiceAssembly.shared.makeRecipeListViewController(for: category)
        navigationController.pushViewController(viewController, animated: true)
    }

    func closeRecipeList(for category: FRLib.Category) {
        navigationController.popViewController(animated: true)
    }

    func showRecipe(id: String) {
        let viewController = ServiceAssembly.shared.makeRecipeDetailsViewController(for: id)
        if UIDevice.current.userInterfaceIdiom == .pad {
            viewController.preferredContentSize = CGSize(width: 800, height: 1000)
        }
        findViewControllerToPresent().present(viewController, animated: true)
    }

    func closeRecipe(id: String) {
        let presentingViewController = findViewControllerToPresent()
        findTopViewController(
            withRootViewController: presentingViewController.presentingViewController ?? navigationController
        ).dismiss(animated: true)
    }

    func showYouTube(for url: URL) {
        let view = FullScreenWebView(url: url) { [weak self] in
            self?.closeYouTube(for: url)
        }
        let viewController = UIHostingController(rootView: view)
        if UIDevice.current.userInterfaceIdiom == .pad {
            viewController.modalPresentationStyle = .fullScreen
        }
        findViewControllerToPresent().present(viewController, animated: true)
    }

    func closeYouTube(for url: URL) {
        let presentingViewController = findViewControllerToPresent()
        findTopViewController(
            withRootViewController: presentingViewController.presentingViewController ?? navigationController
        ).dismiss(animated: true)
    }
}
