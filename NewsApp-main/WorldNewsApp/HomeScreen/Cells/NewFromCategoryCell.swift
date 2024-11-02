//
//  NewFromCategoryCollectionViewCell.swift
//  WorldNewsApp
//
//  Created by Igor Guryan on 25.10.2024.
//

import UIKit

class NewFromCategoryCell: UICollectionViewCell {
    static let identifier = String(describing: NewFromCategoryCell.self)
    
    var bookMarkChangeColor: Bool = false
    
    lazy var categoryNameLabel: UILabel = {
        let label = UILabel()
        label.text = "POLITICS"
        label.font = .Inter.bold.size(of: 14)
        label.textColor = AppColors.grayLighter
        return label
    }()
    
    lazy var newNameLabel: UILabel = {
        let label = UILabel()
        label.text = "The latest situation in the presidential election"
        label.font = .Inter.bold.size(of: 16)
        label.textColor = .white
        label.numberOfLines = 3
        return label
    }()
    
    private lazy var bookmarkButton: UIButton = {
            let element = UIButton()
            element.tintColor = .white
            element.setBackgroundImage(UIImage(systemName: "bookmark"), for: .normal)
            element.addTarget(self, action: #selector(addToBookmarks), for: .touchUpInside)
            return element
        }()
    
    lazy var newImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "article")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func addToBookmarks() {
           if bookMarkChangeColor == false {
               bookmarkButton.setBackgroundImage(UIImage(systemName: "bookmark.fill"), for: .normal)
               bookmarkButton.tintColor = .systemRed
               bookMarkChangeColor = true
   //            guard let data = newsData else { return }
   //            //print(data)
   //            bookmarkManager.saveNewsToDefaults(news: data)
           } else {
               bookmarkButton.setBackgroundImage(UIImage(systemName: "bookmark"), for: .normal)
               bookmarkButton.tintColor = .white
               bookMarkChangeColor = false
   //            guard let data = newsData else { return }
   //            //print(data)
   //            bookmarkManager.deleteNewsFromDefaults(news: data)
           }
       }
    
    private func setupCell() {
        contentView.layer.cornerRadius = 12
        contentView.layer.masksToBounds = true
        contentView.backgroundColor = .gray
        setupLabel()
        contentView.disableChildrenTAMIC()
    }
    
    private func setupLabel() {
        contentView.addSubview(newImageView)
        contentView.addSubview(categoryNameLabel)
        contentView.addSubview(newNameLabel)
        contentView.addSubview(bookmarkButton)

        NSLayoutConstraint.activate([
            newNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            newNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            newNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24),
        
//            bookmarkButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
//            bookmarkButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            
            bookmarkButton.topAnchor.constraint(equalTo: newImageView.topAnchor, constant: 24),
            bookmarkButton.trailingAnchor.constraint(equalTo: newImageView.trailingAnchor, constant: -24),
            
            categoryNameLabel.bottomAnchor.constraint(equalTo: newNameLabel.topAnchor, constant: -20),
            categoryNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            categoryNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
        
            newImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            newImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            newImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            newImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
        
            
        ])
    }
    
    func configureCell(image: URL?, topic: String, news: String, newsData: News) {
        categoryNameLabel.text = topic
        newNameLabel.text = news
            
//            if let image = image {
//                latestNewsImage.kf.setImage(with: image)
//            } else {
//                latestNewsImage.image = UIImage(named: "berlin")
            }
        }
