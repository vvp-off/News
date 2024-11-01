//
//  CategoryCell.swift
//  WorldNewsApp
//
//  Created by Дмитрий Волков on 31.10.2024.
//


import UIKit

class CategoryCell: UICollectionViewCell {
    
    var category: Category?
    
    let titleLabel: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textAlignment = .center
        title.font = UIFont.Inter.bold.size(of: 16)
        return title
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setCell()
        setConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    func setCell(){
        addSubview(titleLabel)
        self.backgroundColor = AppColors.lightBlue
        layer.cornerRadius = 15
        layer.borderColor = AppColors.lightBlue.cgColor
        layer.borderWidth = 1.0
        clipsToBounds = true
    }
    
    func configure(with category: Category){
        self.category = category
        titleLabel.text = category.name.rawValue
    }
    
    func setConstraints(){
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
}

