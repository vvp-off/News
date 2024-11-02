//
//  LabelExtensions.swift
//  WorldNewsApp
//
//  Created by Alexander Bokhulenkov on 02.11.2024.
//

import UIKit

extension UILabel {
    convenience init(font: UIFont) {
        self.init()
        self.font = font
        self.textAlignment = .center
        self.numberOfLines = 0
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
