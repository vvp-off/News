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
    
    override var isSelected: Bool {
            didSet {
                if isSelected {
                    contentView.backgroundColor = AppColors.purplePrimary
                    titleLabel.textColor = .white
                    
                } else {
                    contentView.backgroundColor = AppColors.grayLighter
                    titleLabel.textColor = AppColors.grayDark
                }
            }
        }
    
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
        contentView.backgroundColor = AppColors.grayLighter
        titleLabel.text = "Category"
        titleLabel.font = .Inter.medium.size(of: 12)
        titleLabel.textColor = AppColors.grayPrimary
//        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
    
    func configureCell(with category: String) {
        titleLabel.text = category
    }
}
