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
}


