//
//  HomeViewController.swift
//  WorldNewsApp
//
//  Created by Igor Guryan on 21.10.2024.
//

import UIKit

final class HomeViewController: UIViewController {
    
    private let collectionView: UICollectionView = .createCollectionView(with: .newsLayout())
    private var sections = [NewsSection]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .always
        view.backgroundColor = .systemBackground
        configureNagivationBar()
        configureCollectionView()
        fetchData()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
        
//        NSLayoutConstraint.activate([
//            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100)])
//            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    }
    
    private func configureCollectionView() {
        view.addSubview(collectionView)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(CategorieCell.self, forCellWithReuseIdentifier: CategorieCell.identifier)
        collectionView.register(NewFromCategoryCell.self , forCellWithReuseIdentifier: NewFromCategoryCell.identifier)
        collectionView.register(RecNewCell.self, forCellWithReuseIdentifier: RecNewCell.identifier)
        collectionView.register(SectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderView.identifier)
        collectionView.register(SearchCell.self, forCellWithReuseIdentifier: SearchCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        
//        NSLayoutConstraint.activate([
//            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100)])
//            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
////            collectionView.widthAnchor.constraint(equalToConstant: 96),
    }
    
    private func fetchData() {
        //Categories
        //News from categorie
        //Recommended for you
        sections.append(.search)
        sections.append(.categories)
        sections.append(.newsFromCategory)
        sections.append(.recommendedNews)
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       10
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderView.identifier, for: indexPath) as! SectionHeaderView
        
        header.configure(with: "Recommended for you", buttonTitle: "See All", tapAction: didTapSeeAll)
        return header
  
   }
    
    func configureNagivationBar() {
        navigationItem.title = "Browse"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = sections[indexPath.section]
        switch section {
        case .search:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCell.identifier, for: indexPath)
            return cell
        case .categories:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategorieCell.identifier, for: indexPath)
            return cell
        case .newsFromCategory:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewFromCategoryCell.identifier, for: indexPath)
            return cell
        case .recommendedNews:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecNewCell.identifier, for: indexPath)
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = sections[indexPath.section]
        switch section {
        case .categories:
            didSelectCategory(at: indexPath.item)
            print("Selected category #\(indexPath.item)")
        case .newsFromCategory, .recommendedNews:
            didSelectNew(at: indexPath.item)
            print("Selected new #\(indexPath.item)")
        case .search:
            print("Search selected")
            
        }
    }
    
    
    
    @objc func didTapSeeAll() {
        // Переход на экран Bookmarks с передачей туда новостей из секции recommendedNews
    }
    
    func didSelectCategory(at index: Int) {
        // Изменение состояния секции categoryNews
        // Смена ячейки категории на выбранную и изменение старой ячейки на не выбранную
    }
    
    func didSelectNew(at index: Int) {
        // Переход на экран result и передача туда новости
    }
    
}
