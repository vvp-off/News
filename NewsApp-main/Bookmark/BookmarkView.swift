//
//  BookmarkView.swift
//  WorldNewsApp
//
//  Created by Дмитрий Волков on 30.10.2024.
//

import UIKit

class BookmarkView: UIView {

    //MARK: - Properties

    var collectionView: UICollectionView!

    let headerLabel: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.numberOfLines = 0
        title.textAlignment = .left
        title.textColor = AppColors.blackDark
        title.font = UIFont.Inter.semibold.size(of: 26)
        title.text = "Bookmarks"
        return title
    }()
    
    let subheaderLabel: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.numberOfLines = 2
        title.textAlignment = .left
        title.textColor = AppColors.grayPrimary
        title.font = UIFont.Inter.regular.size(of: 18)
        title.text = "Saved articles to the library"
        return title
    }()
    
    let noBookmarksLabel: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textAlignment = .center
        title.numberOfLines = 0
        title.tintColor = .systemGray6
        title.text = "You haven't saved any articles yet. Start reading and bookmarking them now."
        title.font = UIFont.Inter.regular.size(of: 18)
        return title
    }()
    
    let noBookMarkImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.tintColor = .systemBlue
        image.backgroundColor = AppColors.lightBlue
        image.clipsToBounds = true
        image.layer.cornerRadius = 40
        
        let systemImageView = UIImageView()
            systemImageView.translatesAutoresizingMaskIntoConstraints = false
            systemImageView.image = UIImage(systemName: "text.book.closed")
            systemImageView.tintColor = .systemBlue
            systemImageView.contentMode = .scaleAspectFit

            image.addSubview(systemImageView)

            NSLayoutConstraint.activate([
                systemImageView.widthAnchor.constraint(equalToConstant: 30),
                systemImageView.heightAnchor.constraint(equalToConstant: 30),
                systemImageView.centerXAnchor.constraint(equalTo: image.centerXAnchor),
                systemImageView.centerYAnchor.constraint(equalTo: image.centerYAnchor)
            ])
        
        
        
        return image
    }()


    //MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setCollectionView()
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Setup UI
    private func setupViews() {
        backgroundColor = .white
        [headerLabel, subheaderLabel].forEach { addSubview($0) }
    }
        
    func reloadCollectionView() {
        collectionView.reloadData()
    }

}


private extension BookmarkView {
    func setCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 15
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        [collectionView, noBookmarksLabel, noBookMarkImage].forEach { addSubview($0) }
    }
}

private extension BookmarkView {
    func setConstraints() {
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 70),
            headerLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            subheaderLabel.topAnchor.constraint(equalTo: headerLabel.topAnchor, constant: 40),
            subheaderLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            collectionView.topAnchor.constraint(equalTo: subheaderLabel.topAnchor, constant: 50),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -50),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            noBookmarksLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 50),
            noBookmarksLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 60),
            noBookmarksLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -60),
            noBookMarkImage.bottomAnchor.constraint(equalTo: noBookmarksLabel.topAnchor, constant: -30),
            noBookMarkImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            noBookMarkImage.widthAnchor.constraint(equalToConstant: 80),
            noBookMarkImage.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
}

