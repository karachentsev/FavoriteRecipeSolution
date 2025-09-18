//
//  StoragePublishService.swift
//  FavoriteRecipeLibrary
//
//  Created by Karachentsev Oleksandr on 17.08.2025.
//

import Combine
import CoreData

extension FRLib {

    // MARK: - StoragePublishServicing

    public protocol StoragePublishServicing: Actor {
        func getRecipeDetails(id: String) async -> FRLib.RecipeDetails?
        func getFavoriteRecipeStream(id: String) -> AsyncStream<FRLib.RecipeDetails>
        func getFavoriteRecipesStream(sortedBy: FRLib.StoragePublishService.SortedBy) -> AsyncStream<[[FRLib.FavoriteRecipe]]>
    }

    // MARK: - StoragePublishService

    public actor StoragePublishService: StoragePublishServicing {

        // MARK: - Properties

        private let container: NSPersistentContainer
        private let context: NSManagedObjectContext
        private var lastToken: PersistentHistoryToken?

        // MARK: - Init / Deinit

        init(_ container: NSPersistentContainer) {
            self.container = container
            context = container.newBackgroundContext()
        }

        // MARK: - Private

        private func fetchPersistentHistoryTransactionsAndChanges() async {
            lastToken = await context.perform { [lastToken] in
                let changeRequest = NSPersistentHistoryChangeRequest.fetchHistory(after: lastToken?.value)
                guard let historyResult = try? self.context.execute(changeRequest) as? NSPersistentHistoryResult,
                      let history = historyResult.result as? [NSPersistentHistoryTransaction], !history.isEmpty else {
                    return lastToken
                }
                var newToken: PersistentHistoryToken?
                for transaction in history {
                    self.context.mergeChanges(fromContextDidSave: transaction.objectIDNotification())
                    newToken = .init(value: transaction.token)
                }
                return newToken
            }
        }
    }
}

extension FRLib.StoragePublishService {
    public func getRecipeDetails(id: String) async -> FRLib.RecipeDetails? {
        return await context.perform {
            var result: FRLib.RecipeDetails?
            if let entity = RecipeDetailsEntity.findFirst(by: id, in: self.context) {
                result = .init(entity: entity)
            }
            return result
        }
    }

    public func getFavoriteRecipeStream(id: String) -> AsyncStream<FRLib.RecipeDetails> {
        return AsyncStream { continuation in
            let task = Task {
                if let recipeDetails = await getRecipeDetails(id: id) {
                    continuation.yield(recipeDetails)
                }

                for await _ in NotificationCenter.default.notifications(named: .NSPersistentStoreRemoteChange,
                                                                        object: container.persistentStoreCoordinator) {
                    await fetchPersistentHistoryTransactionsAndChanges()
                    if let recipeDetails = await getRecipeDetails(id: id) {
                        continuation.yield(recipeDetails)
                    }
                }
            }
            continuation.onTermination = { _ in
                task.cancel()
            }
        }
    }

    public func getFavoriteRecipesStream(sortedBy: SortedBy) -> AsyncStream<[[FRLib.FavoriteRecipe]]> {
        return AsyncStream { continuation in
            let task = Task {
                continuation.yield(await getFavoriteRecipes(sortedBy: sortedBy))

                for await _ in NotificationCenter.default.notifications(named: .NSPersistentStoreRemoteChange,
                                                                        object: container.persistentStoreCoordinator) {
                    await fetchPersistentHistoryTransactionsAndChanges()
                    continuation.yield(await getFavoriteRecipes(sortedBy: sortedBy))
                }
            }
            continuation.onTermination = { _ in
                task.cancel()
            }
        }
    }

    private func getFavoriteRecipes(sortedBy: SortedBy) async -> [[FRLib.FavoriteRecipe]] {
        return await context.perform {
            var result = [[FRLib.FavoriteRecipe]]()
            let predicate = NSPredicate(format: "\(#keyPath(RecipeDetailsEntity.isFavorite)) == %d", true)
            var sortDescriptors = [sortedBy.descriptor]
            if sortedBy != .name {
                sortDescriptors.append(SortedBy.name.descriptor)
            }
            guard let entities = RecipeDetailsEntity.findAll(with: predicate, sortDescriptors: sortDescriptors,
                                                             in: self.context) else {
                return result
            }
            for entity in entities {
                let recipe = FRLib.FavoriteRecipe(entity: entity)
                guard !result.isEmpty else {
                    result.append([recipe])
                    continue
                }

                switch sortedBy {
                case .name:
                    result[0].append(recipe)
                case .categoryName:
                    if result.last?.first?.categoryName != recipe.categoryName {
                        result.append([recipe])
                    } else {
                        result[result.count - 1].append(recipe)
                    }
                case .area:
                    if result.last?.first?.area != recipe.area {
                        result.append([recipe])
                    } else {
                        result[result.count - 1].append(recipe)
                    }
                }
            }
            return result
        }
    }
}

extension FRLib.StoragePublishService {
    public enum SortedBy: String, CaseIterable, Sendable, Identifiable {

        // MARK: - Cases

        case name, categoryName, area

        // MARK: - Getters properties

        public var title: String {
            switch self {
            case .name: "name"
            case .categoryName: "category"
            case .area: "area"
            }
        }

        var descriptor: NSSortDescriptor {
            switch self {
            case .name: NSSortDescriptor(key: "\(#keyPath(RecipeDetailsEntity.name))", ascending: true)
            case .categoryName: NSSortDescriptor(key: "\(#keyPath(RecipeDetailsEntity.categoryName))", ascending: true)
            case .area: NSSortDescriptor(key: "\(#keyPath(RecipeDetailsEntity.area))", ascending: true)
            }
        }

        // MARK: - Identifiable

        public var id: String { rawValue }
    }
}

extension FRLib.StoragePublishService {
    private struct PersistentHistoryToken: @unchecked Sendable {
        let value: NSPersistentHistoryToken?
    }
}
