//
//  News.swift
//  WorldNewsApp
//
//  Created by Alexander Bokhulenkov on 25.10.2024.
//

import Foundation

// MARK: - Article
struct News {
    let sourceName: String
    let author: String
    let title: String
    let description: String
    let url: String
    let urlToImage: String
    let publishedAt: Date?
    let content: String
    
    init(from article: Article) {
        self.sourceName = article.source?.name ?? ""
        self.author = article.author ?? ""
        self.title = article.title ?? ""
        self.description = article.description ?? ""
        self.url = article.url ?? ""
        self.urlToImage = article.urlToImage ?? ""
        self.publishedAt = article.publishedAt
        self.content = article.content ?? ""
    }
}
