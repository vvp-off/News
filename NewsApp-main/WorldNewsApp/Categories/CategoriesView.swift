//
//  CategoriesView.swift
//  WorldNewsApp
//
//  Created by Дмитрий Волков on 21.10.2024.
//

import UIKit

class CategoriesView: UIView {
    
    //MARK: - Properties
     let categoryArray = ["Sports", "Politics", "Life", "Gaming", "Animals", "Nature", "Food", "Art", "History", "Fashion", "Covid-19", "Middle East"]
    
    var collectionView: UICollectionView!
    
    
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
    }
    
}


private extension CategoriesView {
    func setCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 20
        layout.minimumLineSpacing = 20
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: "cell")
        addSubview(collectionView)
    }
}

private extension CategoriesView {
    func setConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.topAnchor, constant: 70),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -50),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20)
        ])
    }
}


extension CategoriesView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
}

extension CategoriesView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CategoryCell
        cell.titleLabel.text = categoryArray[indexPath.row]
        return cell
    }
}

extension CategoriesView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 20 // Padding for the collection view edges and item spacing
        let itemWidth = (collectionView.frame.width - padding) / 2 // Two cells per row
        return CGSize(width: itemWidth, height: 72)
    }
}



