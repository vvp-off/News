//
//  Category.swift
//  WorldNewsApp
//
//  Created by Дмитрий Волков on 30.10.2024.
//

import Foundation

struct Category: Codable {
    enum Name: String, Codable {
            case business
            case entertainment
            case general
            case health
            case science
            case sports
            case technology
    }

    let name: Name
}
