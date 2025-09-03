//
//  AppDelegate.swift
//  FavoriteRecipemacOS
//
//  Created by Karachentsev Oleksandr on 21.07.2025.
//

import Cocoa
import SwiftUI
import FavoriteRecipeLibrary

class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        _ = FRLib.PersistentContainer.shared
        AppRouter.shared.setup()
    }
}
