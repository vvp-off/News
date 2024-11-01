//
//  CategoriesView.swift
//  WorldNewsApp
//
//  Created by Дмитрий Волков on 31.10.2024.
//


import UIKit

class CategoriesView: UIView {
    
    //MARK: - Properties
    
    let storageManager = StorageManager()
    var collectionView: UICollectionView!
    
    let headerLabel: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.numberOfLines = 0
        title.textAlignment = .left
        title.textColor = AppColors.blackDark
        title.font = UIFont.Inter.semibold.size(of: 24)
        title.text = "Categories"
        return title
    }()
    
    let subheaderLabel: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.numberOfLines = 0
        title.textAlignment = .left
        title.textColor = AppColors.grayPrimary
        title.font = UIFont.Inter.regular.size(of: 18)
        title.text = "Thousands of articles in each category"
        return title
    }()
    
    let button: UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.titleLabel?.font = UIFont.Inter.bold.size(of: 18)
        button.backgroundColor = AppColors.purplePrimary
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = true
        button.isHidden = true
        return button
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
        [headerLabel, subheaderLabel, button].forEach { addSubview($0) }
    }
    
}


private extension CategoriesView {
    func setCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 20
        layout.minimumLineSpacing = 20
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(collectionView)
    }
}

private extension CategoriesView {
    func setConstraints() {
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 70),
            headerLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            subheaderLabel.topAnchor.constraint(equalTo: headerLabel.topAnchor, constant: 40),
            subheaderLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            subheaderLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            collectionView.topAnchor.constraint(equalTo: subheaderLabel.bottomAnchor, constant: 30),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -200),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            button.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -150),
            button.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            button.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}


