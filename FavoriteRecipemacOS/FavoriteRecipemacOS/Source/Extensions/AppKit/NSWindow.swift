//
//  NSWindow.swift
//  FavoriteRecipemacOS
//
//  Created by Karachentsev Oleksandr on 30.07.2025.
//

import AppKit

// MARK: - NSWindow

extension NSWindow {
    func present(_ viewController: NSViewController) {
        findTopViewController().present(viewController, animator: PresentAnimator())
    }

    func dismissViewController(by identifier: NSUserInterfaceItemIdentifier) {
        var presentedViewController: NSViewController? = findTopViewController()
        while presentedViewController?.identifier != identifier && presentedViewController != nil {
            presentedViewController = presentedViewController?.presentingViewController
        }
        guard let presentedViewController else { return }
        presentedViewController.presentingViewController?.dismiss(presentedViewController)
    }

    private func findTopViewController() -> NSViewController {
        guard let contentViewController else { fatalError("No content view controller") }

        func getTopViewController(from viewController: NSViewController) -> NSViewController {
            if let presentedViewController = viewController.presentedViewControllers?.first {
                return getTopViewController(from: presentedViewController)
            }
            return viewController
        }

        return getTopViewController(from: contentViewController)
    }
}

// MARK: - PresentAnimator

@MainActor
private final class PresentAnimator: NSObject, NSViewControllerPresentationAnimator {
    
    // MARK: - Static properties
    
    static private let duration: TimeInterval = 0.5
    
    // MARK: - Properties
    
    private lazy var containerView: NSView = {
        let view = NSView()
        let disabledView = UserInteractionDisabledView()
        view.addFitSizeSubview(disabledView)
        return view
    }()
    
    // MARK: - NSViewControllerPresentationAnimator
    
    func animatePresentation(of viewController: NSViewController, from fromViewController: NSViewController) {
        let presentedView = viewController.view
        presentedView.wantsLayer = true
        presentedView.alphaValue = 0

        fromViewController.addChild(viewController)

        containerView.addFitSizeSubview(presentedView)
        fromViewController.view.addFitSizeSubview(containerView)
        
        NSAnimationContext.runAnimationGroup { context in
            context.duration = Self.duration
            presentedView.animator().alphaValue = 1
        }
    }
    
    func animateDismissal(of viewController: NSViewController, from fromViewController: NSViewController) {
        NSAnimationContext.runAnimationGroup { context in
            context.duration = Self.duration
            containerView.alphaValue = 0
        } completionHandler: {
            self.containerView.removeFromSuperview()
            viewController.removeFromParent()
        }
    }
}

private final class UserInteractionDisabledView: NSView {
    override func hitTest(_ point: NSPoint) -> NSView? { return self }
    override func mouseDown(with event: NSEvent) { }
}
