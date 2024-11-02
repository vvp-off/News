//
//  CategoriesViewController.swift
//  WorldNewsApp
//
//  Created by Дмитрий Волков on 31.10.2024.
//

import UIKit

class CategoriesViewController: UIViewController, UIViewControllerTransitioningDelegate {
    
    //MARK: - Properties
    let categoriesView = CategoriesView()
    let storageManager = StorageManager()
    
    var categories = [Category]()
    let categoryArray = [{Category(name: .business)}, {Category(name: .entertainment)}, {Category(name: .general)}, {Category(name: .health)}, {Category(name: .technology)}, {Category(name: .science)}, {Category(name: .sports)}]
    
    var cellColor = UIColor(named: "white")
    var onBoardingIsDone: Bool = false

    //MARK: - Life cycle
    override func loadView() {
        view = categoriesView
        onBoardingIsDone = storageManager.isOnboardingDone()
        categoriesView.collectionView.dataSource = self
        categoriesView.collectionView.delegate = self
        categoriesView.collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categories = storageManager.getCategories()
        
        if !onBoardingIsDone {
            setCategoryBoarding()
        }
        
        categoriesView.button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
    }

    //MARK: - Methods

}

extension CategoriesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? CategoryCell {
            
            
            let categories = storageManager.getCategories()
            guard let category = cell.category else { return }
            
            if !categories.contains(where: { $0.name == category.name }) {
                cell.backgroundColor = AppColors.purplePrimary
                cell.titleLabel.textColor = .white
                storageManager.addGategory(category)
            } else {
                //cell.backgroundColor = AppColors.lightBlue
                cell.backgroundColor = cellColor
                cell.titleLabel.textColor = AppColors.grayPrimary
                
                storageManager.removeCategory(category)
            }
        }
    }
    
}

extension CategoriesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CategoryCell
        cell.configure(with: categoryArray[indexPath.row]())
        
        
        let categories = storageManager.getCategories()
        let category = cell.category
        
        if categories.contains(where: { $0.name == category!.name }) {
            cell.backgroundColor = AppColors.purplePrimary
            cell.titleLabel.textColor = .white
        } else {
            cell.backgroundColor = cellColor
            //cell.backgroundColor = AppColors.lightBlue
            cell.titleLabel.textColor = AppColors.grayPrimary
        }
        
        return cell
    }
}

extension CategoriesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 20
        let itemWidth = (collectionView.frame.width - padding) / 2
        return CGSize(width: itemWidth, height: 72)
    }
    
    
}

extension CategoriesViewController {
    func setCategoryBoarding(){
        categoriesView.headerLabel.text = "Select your favourite topics"
        categoriesView.subheaderLabel.text = "Select some of your favourite topics to let us suggest better news for you"
        cellColor = AppColors.lightBlue
        categoriesView.button.isHidden = false
    }
    
    @objc func buttonTapped(){
        let nextVC = TabBarController()
        nextVC.modalPresentationStyle = .custom
        nextVC.transitioningDelegate = self
        present(nextVC, animated: true)
    }
}






