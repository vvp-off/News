//
//  StorageManager.swift
//  WorldNewsApp
//
//  Created by Дмитрий Волков on 30.10.2024.
//


import Foundation

protocol StorageManagerProtocol {
    func addArticleToFavourites(_ article: Article)
    func getFavouriteArticles() -> [Article]
    func removeArticleFromFavourites(_ article: Article)
    func addUser(_ user: User)
    func getUsers() -> [User]
    func setCurrentUser(_ user: User)
    func getCurrentUser() -> User
    func getCategories() -> [Category]
    func addGategory(_ category: Category)
    func removeCategory(_ category: Category)
    func isLoggedIn() -> Bool
    func logIn()
    func logOut()
    func clearUserData()
    func setOnboarding()
    func resetOnboarding()
    func isOnboardingDone() -> Bool
}

final class StorageManager {
    public enum Keys: String {
        case favouriteArticles
        case users
        case isLoggedIn
        case categories
        case currentUser
        case isOnboargingDone
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

    func getFavouriteArticles() -> [Article] {
        return restore(forKey: .favouriteArticles, as: [Article].self) ?? []
    }
    
    func addArticleToFavourites(_ article: Article) {
        var articles = getFavouriteArticles()
        
        if !articles.contains(where: { $0.url == article.url }) {
            articles.append(article)
            store(articles, forKey: .favouriteArticles)
            print("Article successfully added")
        }
    }
    
    func removeArticleFromFavourites(_ article: Article) {
        var articles = getFavouriteArticles()
        articles.removeAll { $0.url == article.url }
        store(articles, forKey: .favouriteArticles)
    }
    
    func getUsers() -> [User] {
        return restore(forKey: .users, as: [User].self) ?? []
    }
    
    func addUser(_ user: User) {
        var users = getUsers()
        
        if !users.contains(where: { $0.username == user.username }) {
            users.append(user)
            store(users, forKey: .users)
            print("User successfully added")
        }
    }
    
    func getCategories() -> [Category] {
        return restore(forKey: .categories, as: [Category].self) ?? []
    }
    
    func addGategory(_ category: Category) {
        var categories = getCategories()

        if !categories.contains(where: { $0.name == category.name }) {
            categories.append(category)
            store(categories, forKey: .categories)
            print("Category successfully added")
        }
    }
    
    func removeCategory(_ category: Category) {
        var categories = getCategories()
        categories.removeAll { $0.name == category.name }
        store(categories, forKey: .categories)
    }
    
    func setCurrentUser(_ user: User) {
        store(user, forKey: .currentUser)
    }
    
    func getCurrentUser() -> User {
        restore(forKey: .currentUser, as: User.self)!
    }
    
    func isLoggedIn() -> Bool {
        restore(forKey: .isLoggedIn, as: Bool.self) ?? false
    }
    
    func logIn() {
        store(true, forKey: .isLoggedIn)
    }
    
    func logOut() {
        store(false, forKey: .isLoggedIn)
    }
    
    func setOnboarding() {
        store(true, forKey: .isOnboargingDone)
    }
    
    func resetOnboarding() {
        store(false, forKey: .isOnboargingDone)
    }
    
    func isOnboardingDone() -> Bool {
        restore(forKey: .isOnboargingDone, as: Bool.self) ?? false
    }
    
    
    func clearUserData() {
        let emptyCategories: [Category] = []
        let emptyFavouriteArticles: [Category] = []
        store(emptyCategories, forKey: .categories)
        store(emptyFavouriteArticles, forKey: .categories)
        UserDefaults.standard.removeObject(forKey: "currentUser")
    }
}
