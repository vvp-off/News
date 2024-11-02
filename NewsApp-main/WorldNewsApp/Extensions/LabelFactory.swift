//
//  LabelExtensions.swift
//  WorldNewsApp
//
//  Created by Alexander Bokhulenkov on 02.11.2024.
//

import UIKit

final class LabelFactory {
    static func createTitleLabel(with text: String) ->UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = AppColors.blackDark
        label.font = UIFont.Inter.bold.size(of: 24)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    static func createSubtitleLabel(with text: String) ->UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = AppColors.blackDark
        label.font = UIFont.Inter.medium.size(of: 14)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    static func paddingLabel(text: String) -> NSAttributedString {
        let label = UILabel()
        label.numberOfLines = 0
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center // Центрирование текста
        paragraphStyle.firstLineHeadIndent = 10 // Отступ первой строки
        paragraphStyle.headIndent = 5 // Отступ слева для остальных строк
        paragraphStyle.tailIndent = -5 // Отступ справа
        
        let attributes: [NSAttributedString.Key: Any] = [
            .paragraphStyle: paragraphStyle,
            .foregroundColor: UIColor.black,// цвета и шрифт глянь поставь который надо
            .font: UIFont.systemFont(ofSize: 16)
        ]
        
        let attributedString = NSAttributedString(string: text, attributes: attributes)
        return attributedString
    }
}
