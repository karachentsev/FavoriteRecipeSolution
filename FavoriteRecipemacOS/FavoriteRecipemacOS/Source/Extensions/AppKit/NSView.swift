//
//  NSView.swift
//  FavoriteRecipemacOS
//
//  Created by Karachentsev Oleksandr on 31.07.2025.
//

import AppKit

extension NSView {
    func addFitSizeSubview(_ view: NSView) {
        addSubview(view)

        view.translatesAutoresizingMaskIntoConstraints = true
        view.frame = bounds
        view.autoresizingMask = [.width, .height]
    }
}
