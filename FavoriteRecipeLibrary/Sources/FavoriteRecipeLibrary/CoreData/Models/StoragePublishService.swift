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
        private var lastToken: NSPersistentHistoryToken?

        // MARK: - Init / Deinit

        init(_ container: NSPersistentContainer) {
            self.container = container
            context = container.newBackgroundContext()
        }

        // MARK: - Private

        private func fetchPersistentHistoryTransactionsAndChanges() {
            context.performAndWait {
                let changeRequest = NSPersistentHistoryChangeRequest.fetchHistory(after: lastToken)
                guard let historyResult = try? context.execute(changeRequest) as? NSPersistentHistoryResult,
                      let history = historyResult.result as? [NSPersistentHistoryTransaction], !history.isEmpty else {
                    return
                }
                for transaction in history {
                    context.mergeChanges(fromContextDidSave: transaction.objectIDNotification())
                    lastToken = transaction.token
                }
            }
        }
    }
}

extension FRLib.StoragePublishService {
    public func getRecipeDetails(id: String) async -> FRLib.RecipeDetails? {
        var result: FRLib.RecipeDetails?
        context.performAndWait {
            if let entity = RecipeDetailsEntity.findFirst(by: id, in: context) {
                result = .init(entity: entity)
            }
        }
        return result
    }

    public func getFavoriteRecipeStream(id: String) -> AsyncStream<FRLib.RecipeDetails> {
        return AsyncStream { continuation in
            let task = Task {
                if let recipeDetails = await getRecipeDetails(id: id) {
                    continuation.yield(recipeDetails)
                }

                for await _ in NotificationCenter.default.notifications(named: .NSPersistentStoreRemoteChange,
                                                                        object: container.persistentStoreCoordinator) {
                    fetchPersistentHistoryTransactionsAndChanges()
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
                    fetchPersistentHistoryTransactionsAndChanges()
                    continuation.yield(await getFavoriteRecipes(sortedBy: sortedBy))
                }
            }
            continuation.onTermination = { _ in
                task.cancel()
            }
        }
    }

    private func getFavoriteRecipes(sortedBy: SortedBy) async -> [[FRLib.FavoriteRecipe]] {
        var result = [[FRLib.FavoriteRecipe]]()
        context.performAndWait {
            let predicate = NSPredicate(format: "\(#keyPath(RecipeDetailsEntity.isFavorite)) == %d", true)
            var sortDescriptors = [sortedBy.descriptor]
            if sortedBy != .name {
                sortDescriptors.append(SortedBy.name.descriptor)
            }
            guard let entities = RecipeDetailsEntity.findAll(with: predicate, sortDescriptors: sortDescriptors, in: context) else {
                return
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
        }
        return result
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
