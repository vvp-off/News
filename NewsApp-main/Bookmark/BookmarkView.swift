//
//  BookmarkView.swift
//  WorldNewsApp
//
//  Created by Дмитрий Волков on 21.10.2024.
//

import UIKit

class BookmarkView: UIView {
    
    //MARK: - Properties
     let categoryArray = ["Sports", "Politics", "Life", "Gaming", "Animals", "Nature", "Food", "Art", "History", "Fashion", "Covid-19", "Middle East"]
    
    var collectionView: UICollectionView!
    
    let noBookmarksLabel: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textAlignment = .center
        title.numberOfLines = 0
        title.tintColor = .systemGray6
        title.text = "You haven't saved any articles yet. Start reading and bookmarking them now."
        title.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        return title
    }()
    
    
    //MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setCollectionView()
        loadBookmarkdData()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup UI
    private func setupViews() {
        backgroundColor = .white
    }
    
    private func loadBookmarkdData() {
        let isShown = true
        
        if isShown {
            noBookmarksLabel.isHidden = true
        } else {
            collectionView.isHidden = true
            
        }
    }
    
}


private extension BookmarkView {
    func setCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 20
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(BookmarkCell.self, forCellWithReuseIdentifier: "cell")
        addSubview(collectionView)
        addSubview(noBookmarksLabel)
    }
}

private extension BookmarkView {
    func setConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.topAnchor, constant: 70),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -50),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            noBookmarksLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            noBookmarksLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            noBookmarksLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30)
        ])
    }
}


extension BookmarkView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
}

extension BookmarkView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! BookmarkCell
        cell.titleLabel.text = categoryArray[indexPath.row]
        return cell
    }
}

extension BookmarkView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = collectionView.frame.width
        return CGSize(width: itemWidth, height: 96)
    }
}




