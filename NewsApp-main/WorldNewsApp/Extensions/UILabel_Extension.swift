//
//  UILabel_Extension.swift
//  WorldNewsApp
//
//  Created by Дмитрий Волков on 31.10.2024.
//

import UIKit

extension UILabel {
    
    static func makeHeaderLabel(with heading: String) -> UILabel {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.numberOfLines = 0
        title.textAlignment = .left
        title.textColor = AppColors.blackDark
        title.font = UIFont.Inter.semibold.size(of: 26)
        title.text = heading
        return title
    }
    
    static func makeSubheaderLabel(with heading: String) -> UILabel {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.numberOfLines = 0
        title.textAlignment = .left
        title.textColor = AppColors.grayPrimary
        title.font = UIFont.Inter.regular.size(of: 18)
        title.text = heading
        return title
    }
}
