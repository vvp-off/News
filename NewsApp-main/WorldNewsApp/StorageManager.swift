//
//  StorageManager.swift
//  WorldNewsApp
//
//  Created by Дмитрий Волков on 30.10.2024.
//


import Foundation

protocol StorageManagerProtocol {
    func addArticleToFavourites(_ article: Article, forKey key: StorageManager.Keys)
    func getFavouriteArticles(forKey key: StorageManager.Keys) -> [Article]
    func removeArticleFromFavourites(_ article: Article, forKey key: StorageManager.Keys)
}

final class StorageManager {
    public enum Keys: String {
        case favouriteArticles
        case isLoggedIn
        case categories
    }

    private let userDefaults = UserDefaults.standard
    
    // Helperes methods
    private func encode<T: Encodable>(_ object: T) -> Data? {
        return try? JSONEncoder().encode(object)
    }

    private func decode<T: Decodable>(_ type: T.Type, from data: Data) -> T? {
        return try? JSONDecoder().decode(type, from: data)
    }

    private func store<T: Encodable>(_ object: T, forKey key: Keys) {
        if let encoded = encode(object) {
            userDefaults.set(encoded, forKey: key.rawValue)
        }
    }

    private func restore<T: Decodable>(forKey key: Keys, as type: T.Type) -> T? {
        guard let data = userDefaults.data(forKey: key.rawValue) else { return nil }
        return decode(type, from: data)
    }
}

// MARK: - StorageManagerProtocol
extension StorageManager: StorageManagerProtocol {
    
    func getFavouriteArticles(forKey key: Keys) -> [Article] {
        return restore(forKey: key, as: [Article].self) ?? []
    }
    
    func addArticleToFavourites(_ article: Article, forKey key: Keys) {
        var articles = getFavouriteArticles(forKey: key)
        
        if !articles.contains(where: { $0.url == article.url }) {
            articles.append(article)
            store(articles, forKey: key)
            print("Article successfully added")
        }
    }

    func removeArticleFromFavourites(_ article: Article, forKey key: Keys) {
        var articles = getFavouriteArticles(forKey: key)
        articles.removeAll { $0.url == article.url }
        store(articles, forKey: key)
    }
    
    func getCategories(forKey key: Keys) -> [Category] {
        return restore(forKey: key, as: [Category].self) ?? []
    }
    
    func addGategory(_ category: Category, forKey key: Keys) {
        var categories = getCategories(forKey: key)

        if !categories.contains(where: { $0.name == category.name }) {
            categories.append(category)
            store(categories, forKey: key)
            print("Category successfully added")
        }
    }
    
    func removeCategory(_ category: Category, forKey key: Keys) {
        var categories = getCategories(forKey: key)
        categories.removeAll { $0.name == category.name }
        store(categories, forKey: key)
    }
}

