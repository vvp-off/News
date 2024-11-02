//
//  Untitled.swift
//  WorldNewsApp
//
//  Created by Igor Guryan on 29.10.2024.
//

import UIKit

class SearchCell: UICollectionViewCell {
    static let identifier = String(describing: SearchCell.self)
    
    private let searchBar: UISearchBar = {
        let search = UISearchBar()
        search.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        search.searchTextField.font = .Inter.regular.size(of: 16)
        search.searchTextField.backgroundColor = AppColors.grayLighter
        search.placeholder = "Search"
        return search
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        searchBar.frame = bounds
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        contentView.disableChildrenTAMIC()
        contentView.addSubview(searchBar)
        
//        NSLayoutConstraint.activate([
//            searchBar.heightAnchor.constraint(equalToConstant: 40),
//            searchBar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
//            searchBar.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 20)
//        ])
    }
}
