//
//  CategoriesViewController.swift
//  WorldNewsApp
//
//  Created by Дмитрий Волков on 31.10.2024.
//

import UIKit

class CategoriesViewController: UIViewController {
    
    //MARK: - Properties
    let categoriesView = CategoriesView()
    let storageManager = StorageManager()
    
    var categories = [Category]()

    //MARK: - Life cycle
    override func loadView() {
        view = categoriesView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categories = storageManager.getCategories(forKey: .categories)
        print(categories.count)
        
    }

    //MARK: - Methods

}

