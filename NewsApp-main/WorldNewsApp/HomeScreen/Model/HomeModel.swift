//
//  HomeModel.swift
//  WorldNewsApp
//
//  Created by Igor Guryan on 26.10.2024.
//

import Foundation

// MARK: - Sections

enum NewsSection: Int, Hashable, CaseIterable {
    case search
    case categories
    case newsFromCategory
    case recommendedNews
}

enum HomeCategory: String, Hashable, CaseIterable {
    case random = "Random"
    case sports = "Sports"
    case politics = "Politics"
}
struct New: Hashable, Identifiable  {
    let id = UUID()
    let key: String
    let name: String
    let author: String
    let category: String
    let imageID: Int
    let rating: Double
    let date: Date
}

struct HomeViewModel {
    let categories = HomeCategory.allCases
    let categoryNews: [New]
    let recommendedNews: [New]
    let recommendedNewsHeader: Header
    
    struct Header {
        let title: String
        let button: Button
    }
    
    struct Button {
        let title: String
        let action: () -> Void
    }
    
}
