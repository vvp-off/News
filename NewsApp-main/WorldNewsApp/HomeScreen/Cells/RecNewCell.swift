//
//  RecNewCollectionViewCell.swift
//  WorldNewsApp
//
//  Created by Igor Guryan on 25.10.2024.
//

import UIKit

class RecNewCell: UICollectionViewCell {
    static let identifier = String(describing: RecNewCell.self)
    
    lazy var categoryNameLabel: UILabel = {
        let label = UILabel()
        label.text = "POLITICS"
        label.font = UIFont(name: "Inter-Regular", size: 12)
        label.textColor = UIColor(red: 0.49, green: 0.51, blue: 0.63, alpha: 1)
        return label
    }()
    
    lazy var newNameLabel: UILabel = {
        let label = UILabel()
        label.text = "The latest situation in the presidential election"
        label.font = UIFont(name: "Inter-Medium", size: 16)
        label.textColor = UIColor(red: 0.2, green: 0.21, blue: 0.28, alpha: 1)
        label.numberOfLines = 0
        
        return label
    }()
    
    lazy var newImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "article")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 12
        imageView.layer.masksToBounds = true
        return imageView
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        contentView.layer.cornerRadius = 12
        contentView.layer.masksToBounds = true
        setupLabel()
        contentView.disableChildrenTAMIC()
    }
    
    func configure(with new: New) {
        categoryNameLabel.text = new.category
        newNameLabel.text = new.name
        newImageView.image = UIImage(named: String(new.imageID))
    }
    
    private func setupLabel() {
        contentView.addSomeSubviews(newImageView,categoryNameLabel,newNameLabel)
        
        NSLayoutConstraint.activate([
            newImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            newImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            newImageView.heightAnchor.constraint(equalToConstant: 96),
            newImageView.widthAnchor.constraint(equalToConstant: 96),
                    
            categoryNameLabel.topAnchor.constraint(equalTo: newImageView.topAnchor, constant: 5),
            categoryNameLabel.leadingAnchor.constraint(equalTo: newImageView.trailingAnchor, constant: 16),
            categoryNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
                    
            newNameLabel.topAnchor.constraint(equalTo: categoryNameLabel.bottomAnchor, constant: 8),
            newNameLabel.leadingAnchor.constraint(equalTo: categoryNameLabel.leadingAnchor),
            newNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
                ])
    }
}
