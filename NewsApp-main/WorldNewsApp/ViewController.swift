//
//  ViewController.swift
//  WorldNewsApp
//
//  Created by Дмитрий Волков on 21.10.2024.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    var articles: [News] = []
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColors.purplePrimary
        
        let label = UILabel()
        label.text = "test"
        label.font = .Inter.bold.size(of: 200)
        label.textColor = AppColors.blackDark
        label.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20)
        ])
        
        //        пример поиска. категории меняются по ключу
        fetchNews(apiService: .business)
    }
    
    // MARK: - Methods
    
    func fetchNews(apiService: ApiService) {
        let httpClient = HTTPClient(with: .default)
        
        Task {
            do {
                let articles = try await httpClient.requestData(for: apiService)
                self.articles = articles.map {News(from: $0) }
                
                // Здесь обновляем UI с нашими данными.
                //                DispatchQueue.main.async {
                //                self.loadImage(for: self.articles[0])
                //                }
                
                //                просто тест вывода информации можно удалить
                for sourse in articles {
                    print(sourse.title ?? "")
                }
            }
            catch let error as RequestError {
                print("Произошла ошибка: \(error.errorDescription ?? "Неизвестная ошибка")")
            }
        }
    }
    
    //    кеширование изображения
    /*
     func loadImage(for article: News) {
     let urlToImage = article.urlToImage
     
     Task {
     do {
     if let image = try await ImageService.downloadImage(by: urlToImage) {
     DispatchQueue.main.async {
     //                            self.imageView.image = image
     }
     }
     } catch {
     print("Ошибка сохранения в cache: \(error.localizedDescription)")
     }
     }
     }
     */
}
    
