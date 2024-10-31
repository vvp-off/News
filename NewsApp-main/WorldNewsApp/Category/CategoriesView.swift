//
//  CategoriesView.swift
//  WorldNewsApp
//
//  Created by Дмитрий Волков on 31.10.2024.
//


import UIKit

class CategoriesView: UIView {
    
    //MARK: - Properties
//     let categoryArray = ["Sports", "Politics", "Life", "Gaming", "Animals", "Nature", "Food", "Art", "History", "Fashion", "Covid-19", "Middle East"]
    
    let categoryArray = [{Category(name: .business)}, {Category(name: .entertainment)}, {Category(name: .general)}, {Category(name: .health)}, {Category(name: .technology)}, {Category(name: .science)}, {Category(name: .sports)}]
    
    let storageManager = StorageManager()
    var collectionView: UICollectionView!
    
    let headerLabel: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.numberOfLines = 0
        title.textAlignment = .left
        title.textColor = AppColors.blackDark
        title.font = UIFont.Inter.semibold.size(of: 26)
        title.text = "Categories"
        return title
    }()
    
    let subheaderLabel: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.numberOfLines = 2
        title.textAlignment = .left
        title.textColor = AppColors.grayPrimary
        title.font = UIFont.Inter.regular.size(of: 18)
        title.text = "Thousands of articles in each category"
        return title
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
            headerLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 70),
            headerLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            subheaderLabel.topAnchor.constraint(equalTo: headerLabel.topAnchor, constant: 40),
            subheaderLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            collectionView.topAnchor.constraint(equalTo: subheaderLabel.topAnchor, constant: 50),
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? CategoryCell {
            
            
            let categories = storageManager.getCategories(forKey: .categories)
            guard let category = cell.category else { return }
            
            if !categories.contains(where: { $0.name == category.name }) {
                cell.backgroundColor = AppColors.purplePrimary
                cell.titleLabel.textColor = .white
                storageManager.addGategory(category, forKey: .categories)
            } else {
                //cell.backgroundColor = AppColors.lightBlue
                cell.backgroundColor = .white
                cell.titleLabel.textColor = AppColors.grayPrimary
                
                storageManager.removeCategory(category, forKey: .categories)
            }
        }
    }
    
}

extension CategoriesView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CategoryCell
        cell.configure(with: categoryArray[indexPath.row]())
        
        
        let categories = storageManager.getCategories(forKey: .categories)
        let category = cell.category
        
        if categories.contains(where: { $0.name == category!.name }) {
            cell.backgroundColor = AppColors.purplePrimary
            cell.titleLabel.textColor = .white
        } else {
            cell.backgroundColor = .white
            //cell.backgroundColor = AppColors.lightBlue
            cell.titleLabel.textColor = AppColors.grayPrimary
        }
        
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





