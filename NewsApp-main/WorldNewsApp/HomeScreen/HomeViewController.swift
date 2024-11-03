//
//  HomeViewController.swift
//  WorldNewsApp
//
//  Created by Igor Guryan on 21.10.2024.
//

import UIKit
import Kingfisher

final class HomeViewController: UIViewController {
    
    private var articles: [News]?
    private var recArticles: [News]?
    private let collectionView: UICollectionView = .createCollectionView(with: .newsLayout())
    private var sections: [NewsSection] = [.search, .categories, .newsFromCategory, .recommendedNews]
    private let categories: [String] = ["Entertainment", "Business", "Science", "Technology", "Sports", "Health"]
    private var selectedCategory: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .always
        view.backgroundColor = .systemBackground
        configureNagivationBar()
        configureCollectionView()
        selectedCategory = categories.first
        fetchNews(apiService: .entertainment)
        fetchRecNews(apiService: .business)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
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
    }
    
    func fetchNews(apiService: ApiService) {
        let httpClient = HTTPClient(with: .default)
        
        Task {
            do {
                let articles = try await httpClient.requestData(for: apiService)
                self.articles = articles.map {News(from: $0) }
                
                //                 Здесь обновляем UI с нашими данными.
                DispatchQueue.main.async {
                    self.collectionView.reloadSections(IndexSet(integer: 2))
                }
                
                //                                просто тест вывода информации можно удалить
                for sourse in articles {
                    print(sourse.urlToImage ?? "")
                }
            }
            catch let error as RequestError {
                print("Произошла ошибка: \(error.errorDescription ?? "Неизвестная ошибка")")
            }
        }
    }
    
    func fetchRecNews(apiService: ApiService) {
        
        let httpClient = HTTPClient(with: .default)
        
        Task {
            do {
                let articles = try await httpClient.requestData(for: apiService)
                self.recArticles = articles.map {News(from: $0) }
                
                DispatchQueue.main.async {
                    self.collectionView.reloadSections(IndexSet(integer: 3))
                }
            }
            catch let error as RequestError {
                print("Произошла ошибка: \(error.errorDescription ?? "Неизвестная ошибка")")
            }
        }
    }
}



extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch sections[section] {
        case .search:
            return 1
        case .categories:
            return categories.count
        case .newsFromCategory:
            return 10
        case .recommendedNews:
            return 10
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderView.identifier, for: indexPath) as! SectionHeaderView
        if sections[indexPath.section] == .search {
            header.configure(with: "Discover things of this world", titleFont: TitleFont.small, isButtonHidden: true, buttonTitle: "See All", tapAction: didTapSeeAll)
            return header
        } else if sections[indexPath.section] == .recommendedNews {
            header.configure(with: "Recommended for you", titleFont: TitleFont.big, isButtonHidden: false, buttonTitle: "See All", tapAction: didTapSeeAll)
            return header
        }
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
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCell.identifier, for: indexPath) as! SearchCell
            cell.searchBar.delegate = self
            return cell
        case .categories:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategorieCell.identifier, for: indexPath) as! CategorieCell
            cell.configureCell(with: categories[indexPath.row])
            return cell
        case .newsFromCategory:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewFromCategoryCell.identifier, for: indexPath) as? NewFromCategoryCell else {
                return UICollectionViewCell()
            }
            if let news = articles?[indexPath.row] {
                let imageUrl = news.urlToImage != nil ? URL(string: news.urlToImage) : nil
                let topic = news.sourceName
                let newsTitle = news.title
                
                cell.configureCell(image: imageUrl, topic: topic, news: newsTitle, newsData: news)
            } else {
                cell.newImageView.image = UIImage(named: "city_6")
                cell.categoryNameLabel.text = "НОВОСТЬ"
                cell.newNameLabel.text = "ТЕМА"
            }
            return cell
        case .recommendedNews:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecNewCell.identifier, for: indexPath) as! RecNewCell
            if let news = recArticles?[indexPath.row] {
                cell.configureCell(image: URL(string: news.urlToImage ?? ""), topic: news.sourceName ?? "", news: news.title ?? "", newsData: news)
            }
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = sections[indexPath.section]
        switch section {
        case .categories:
            didSelectCategory(at: indexPath.item)
            print(categories)
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
        switch index {
        case 0: fetchNews(apiService: .entertainment)
        case 1: fetchNews(apiService: .business)
        case 2: fetchNews(apiService: .science)
        case 3: fetchNews(apiService: .technology)
        case 4: fetchNews(apiService: .sports)
        case 5: fetchNews(apiService: .health)
        default: break
        }
    }
        
        func didSelectNew(at index: Int) {
            present(ResultViewController(with: articles![index]), animated: true)
        }
        
    }


extension HomeViewController: UISearchBarDelegate {
    
    func fetchSearchNews(apiService: ApiService) {
        
        let httpClient = HTTPClient(with: .default)
        
        Task {
            do {
                let articles = try await httpClient.requestData(for: apiService)
                let news = articles.map {News(from: $0) }
                
                //                 Здесь обновляем UI с нашими данными.
                DispatchQueue.main.async {
                    //present Bookmark(with: news)
                }
            }
            catch let error as RequestError {
                print("Произошла ошибка: \(error.errorDescription ?? "Неизвестная ошибка")")
            }
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }

    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        if searchBar.text != "" {
            return true
        } else {
            searchBar.placeholder = "Введите запрос"
            return false
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if let search = searchBar.text {
            fetchSearchNews(apiService: .search(search))
        }
    }
}
