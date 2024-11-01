//
//  BookmarkViewController.swift
//  WorldNewsApp
//
//  Created by Дмитрий Волков on 30.10.2024.
//


import UIKit

class BookmarkViewController: UIViewController {

    //MARK: - Properties
    let bookmarkView = BookmarkView()
    let storageManager = StorageManager()
    var articlesArray = [Article]()

    //MARK: - Life cycle
    override func loadView() {
        view = bookmarkView
        bookmarkView.collectionView.dataSource = self
        bookmarkView.collectionView.delegate = self
        bookmarkView.collectionView.register(BookmarkCell.self, forCellWithReuseIdentifier: "cell")
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backButtonTitle = ""
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //loadData()
        loadMockData()
    }

    //MARK: - Methods
    private func loadData() {
        articlesArray = storageManager.getFavouriteArticles(forKey: .favouriteArticles)
        setNoBookmarkState()
        bookmarkView.collectionView.reloadData()
    }
    
    private func loadMockData() {
        articlesArray = [Article(source: Source(id: "1", name: "News"), author: "Ivan", title: "You may not need to throw out those ‘expired’ Covid-19 home tests", description: "description", url: "url", urlToImage: "url", publishedAt: Date(timeIntervalSinceReferenceDate: -123456789.0), content: "content"),
                         Article(source: Source(id: "1", name: "News"), author: "Ivan", title: "Use of race and ethnicity is sometimes ‘harmful’ in medical research, says new report", description: "description", url: "url", urlToImage: "url", publishedAt: Date(timeIntervalSinceReferenceDate: -123456789.0), content: "content"),
                         Article(source: Source(id: "1", name: "News"), author: "Ivan", title: "Are you in perimenopause? Here’s what to look for, according to a doctor", description: "description", url: "url", urlToImage: "url", publishedAt: Date(timeIntervalSinceReferenceDate: -123456789.0), content: "content"),
                         Article(source: Source(id: "1", name: "News"), author: "Ivan", title: "Why some people intentionally cut, burn or bruise themselves", description: "description", url: "url", urlToImage: "url", publishedAt: Date(timeIntervalSinceReferenceDate: -123456789.0), content: "content")]
        
        //articlesArray = []
        
        setNoBookmarkState()
        bookmarkView.collectionView.reloadData()
        
    }
}

// MARK: - Helpers
extension BookmarkViewController {
    
    func setNoBookmarkState(){
        if articlesArray.isEmpty {
            bookmarkView.noBookmarksLabel.isHidden = false
            bookmarkView.noBookMarkImage.isHidden = false
        } else {
            bookmarkView.noBookmarksLabel.isHidden = true
            bookmarkView.noBookMarkImage.isHidden = true
        }
    }
}


// MARK: - UICollectionView DataSource & Delegate
extension BookmarkViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return articlesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! BookmarkCell
        cell.configure(with: articlesArray[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = collectionView.frame.width
        return CGSize(width: itemWidth, height: itemWidth / 3.3)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let article = articlesArray[indexPath.row]
//        articleViewController = ArticleViewController(with: article)
//        articleViewController.hidesBottomBarWhenPushed = true
//        navigationController?.pushViewController(articleViewController, animated: true)
    }
}

