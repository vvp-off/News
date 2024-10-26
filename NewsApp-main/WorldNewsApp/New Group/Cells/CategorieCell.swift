//
//  categorieCollectionViewCell.swift
//  WorldNewsApp
//
//  Created by Igor Guryan on 25.10.2024.
//

import UIKit

class CategorieCell: UICollectionViewCell {
    static let identifier = String(describing: CategorieCell.self)
    
    lazy var categoryName: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 14, weight: .bold)
        view.textColor = .black
        view.textAlignment = .center
        view.layer.borderColor = CGColor(red: 13/255, green: 13/255, blue: 13/255, alpha: 1)
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 16
        view.frame = contentView.bounds
        view.clipsToBounds = true
        view.text = "Category"
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(categoryName)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
