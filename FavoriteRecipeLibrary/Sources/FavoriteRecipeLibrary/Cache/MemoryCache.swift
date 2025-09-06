//
//  MemoryCache.swift
//  FavoriteRecipeLibrary
//
//  Created by Karachentsev Oleksandr on 05.09.2025.
//

import Foundation
#if os(iOS)
import UIKit
#endif

// MARK: - CacheIdentifiable

extension FRLib {
    public protocol CacheIdentifiable: Sendable {
        var id: String { get }
    }
}

// MARK: - MemoryCache

actor MemoryCache<Value: FRLib.CacheIdentifiable> {

    // MARK: - Item

    private struct Item: Sendable {
        let values: [Value]
        var expiresAt = Date()
    }

    // MARK: - Properties

    private var store = [String: Item]()
    private let ttl: TimeInterval

    // MARK: - Getters properties

    private var newExpiresAt: Date { Date().addingTimeInterval(ttl) }

    // MARK: - Init / Deinit

    init(ttl: TimeInterval = 5 * 60) {
        self.ttl = ttl
        Task {
            await startJanitor()
            await observeMemoryWarningsIfAvailable()
        }
    }

    // MARK: - Actions

    func set(_ values: [Value]?, for key: String) {
        if let values {
            store[key] = Item(values: values, expiresAt: newExpiresAt)
        } else {
            store.removeValue(forKey: key)
        }
    }

    func values(for key: String) -> [Value]? {
        guard let entry = store[key] else { return nil }
        store[key]?.expiresAt = newExpiresAt
        return entry.values
    }

    func value(by id: String) -> Value? {
        for (key, entry) in store {
            guard let value = entry.values.first(where: { $0.id == id }) else { continue }
            store[key]?.expiresAt = newExpiresAt
            return value
        }
        return nil
    }

    // MARK: - Private

    private func startJanitor() {
        Task {
            while !Task.isCancelled {
                try? await Task.sleep(for: .seconds(ttl))
                let now = Date()
                for (key, entry) in store {
                    if entry.expiresAt < now {
                        store.removeValue(forKey: key)
                    }
                }
            }
        }
    }

    // MARK: - Memory warnings (iOS only)

    private func observeMemoryWarningsIfAvailable() {
#if os(iOS)
        Task {
            for await _ in NotificationCenter.default.notifications(named: UIApplication.didReceiveMemoryWarningNotification) {
                store.removeAll()
            }
        }
#endif
    }
}
