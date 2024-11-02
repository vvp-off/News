//
//  ApiService.swift
//  WorldNewsApp
//
//  Created by Alexander Bokhulenkov on 25.10.2024.
//

import Foundation

enum ApiService {
    case search(String)
    case business
    case entertainment
    case general
    case health
    case science
    case sports
    case technology
    
    var path: String {
        switch self {
        case .search(let query):
            return "everything?q=\(query)"
        case .business:
            return "top-headlines?category=business"
        case .entertainment:
            return "top-headlines?category=entertainment"
        case .general:
            return "top-headlines?category=general"
        case .health:
            return "top-headlines?category=health"
        case .science:
            return "top-headlines?category=science"
        case .sports:
            return "top-headlines?category=sports"
        case .technology:
            return "top-headlines?category=technology"
        }
    }
}

enum HTTP {
    enum Method: String {
        case get = "GET"
        case post = "POST"
    }
    enum Headers {
        enum Key: String {
            case contentType = "Content-Type"
            case apikey = "X-CMC_PRO_API_KEY"
        }
        enum Value: String {
            case applicationison = "application/json"
        }
    }
}

