//
//  RootNavigationController.swift
//  FavoriteRecipeiOS
//
//  Created by Karachentsev Oleksandr on 29.07.2025.
//

import UIKit

final class RootNavigationController: UINavigationController {

    // MARK: - Life Cycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBarHidden(true, animated: false)
    }
}
