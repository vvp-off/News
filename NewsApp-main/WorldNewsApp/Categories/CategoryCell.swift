//
//  CategoryCell.swift
//  WorldNewsApp
//
//  Created by Дмитрий Волков on 21.10.2024.
//
import UIKit

class CategoryCell: UICollectionViewCell {
    
    let titleLabel: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textAlignment = .center
        title.tintColor = .black
        title.font = UIFont.systemFont(ofSize: 18, weight: .bold)
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
        layer.cornerRadius = 10
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 1.0
        clipsToBounds = true
    }
    
    func setConstraints(){
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
}
