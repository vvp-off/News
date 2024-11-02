//
//  BookmarkCell.swift
//  WorldNewsApp
//
//  Created by Дмитрий Волков on 21.10.2024.
//

import UIKit

class BookmarkCell: UICollectionViewCell {
    
    let categoryLabel: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textAlignment = .center
        title.tintColor = .systemGray6
        title.text = "Art"
        title.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return title
    }()
    
    let titleLabel: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textAlignment = .center
        title.tintColor = .black
        title.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return title
    }()
    
    let imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "article")
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
        addSubview(titleLabel)
        [categoryLabel, titleLabel, imageView].forEach { addSubview($0) }
        //layer.cornerRadius = 10
        //layer.borderColor = UIColor.lightGray.cgColor
        //layer.borderWidth = 1.0
        //clipsToBounds = true
    }
    
    func setConstraints(){
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 97),
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
            categoryLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            categoryLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10)
        ])
    }
}

