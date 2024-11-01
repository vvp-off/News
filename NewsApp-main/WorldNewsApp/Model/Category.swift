//
//  Category.swift
//  WorldNewsApp
//
//  Created by Дмитрий Волков on 30.10.2024.
//

import Foundation

struct Category: Codable {
    enum Name: String, Codable {
            case business = "💼  Business"
            case entertainment = "🎮  Entertainment"
            case general = "🌎  General"
            case health = "🦠  Health"
            case science = "🔭  Science"
            case sports = "⚽️  Sports"
            case technology = "🖥  Technology"
    }

    let name: Name
}
