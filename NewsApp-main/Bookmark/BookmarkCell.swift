//
//  BookmarkCell.swift
//  WorldNewsApp
//
//  Created by Дмитрий Волков on 30.10.2024.
//

import UIKit

class BookmarkCell: UICollectionViewCell {
    

    let categoryLabel: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textAlignment = .left
        title.tintColor = AppColors.grayLighter
        title.font = UIFont.Inter.regular.size(of: 16)
        return title
    }()
    
    let titleLabel: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.numberOfLines = 2
        title.textAlignment = .left
        title.tintColor = AppColors.blackDark
        title.font = UIFont.Inter.bold.size(of: 18)
        return title
    }()
    
    let imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 15
        return image
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
        [categoryLabel, titleLabel, imageView].forEach { addSubview($0) }
    }
    
    func setConstraints(){
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            imageView.widthAnchor.constraint(equalToConstant: frame.width / 3.3),
            imageView.widthAnchor.constraint(equalToConstant: frame.width / 3.3),
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: frame.width / 40),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: frame.width / 22),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -(frame.width / 22)),
            categoryLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: frame.width / 22),
            categoryLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: frame.width / 22)
        ])
    }
    
    // Configure Method
    func configure(with article: Article) {
        titleLabel.text = article.title
        categoryLabel.text = article.author
        imageView.image = UIImage(named: "tempImage")
        categoryLabel.text = "Health"
    }
}

