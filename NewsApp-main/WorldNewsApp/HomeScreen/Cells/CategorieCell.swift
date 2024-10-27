//
//  categorieCollectionViewCell.swift
//  WorldNewsApp
//
//  Created by Igor Guryan on 25.10.2024.
//

import UIKit

class CategorieCell: UICollectionViewCell {
    static let identifier = String(describing: CategorieCell.self)
    
    private let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        contentView.layer.cornerRadius = 16
        contentView.layer.masksToBounds = true
        setupLabel()
        contentView.disableChildrenTAMIC()
    }
    
    private func setupLabel() {
        contentView.addSubview(titleLabel)
        contentView.backgroundColor = UIColor(red: 0.95, green: 0.96, blue: 0.97, alpha: 1)
        titleLabel.text = "Category"
        titleLabel.font = UIFont(name: "Inter-Regular", size: 12)
        titleLabel.textColor = UIColor(red: 0.49, green: 0.51, blue: 0.63, alpha: 1)
        
        titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
