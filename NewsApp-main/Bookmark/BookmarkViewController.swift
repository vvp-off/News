//
//  BookmarkViewController.swift
//  WorldNewsApp
//
//  Created by Дмитрий Волков on 21.10.2024.
//

import UIKit

class BookmarkViewController: UIViewController {
    
    //MARK: - Properties
    let bookmarkView = BookmarkView()

    //MARK: - Life cycle
    override func loadView() {
        view = bookmarkView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtons()
    }

    //MARK: - Methods
    
    private func setupButtons() {
    }
}
