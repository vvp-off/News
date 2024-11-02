//
//  ButtonFactory.swift
//  WorldNewsApp
//
//  Created by Alexander Bokhulenkov on 02.11.2024.
//

import UIKit

final class ButtonFactory {
    
    static func makeButtonWithText(text: String) -> UIButton {
        let button = UIButton(type: .system)
        button.backgroundColor = AppColors.blue
        button.layer.cornerRadius = 20
        button.setTitle(text, for: .normal)
        button.titleLabel?.font = UIFont.Inter.bold.size(of: 24)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
}
