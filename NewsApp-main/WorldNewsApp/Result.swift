//
//  Result.swift
//  WorldNewsApp
//
//  Created by vp.off on 27.10.2024.
//

import UIKit

//struct Articlee {
//    let author: String
//    let title: String
//    let category: String
//    let publicationDate: String
//    var imageUrl: String? // URL изображения
//}

class ResultViewController: UIViewController {
    private var isFavorite: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUII()
    }
    
    func setupUII() {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "MocImage")
        imageView.contentMode = .scaleAspectFill
        
        let scrollView = UIScrollView()
        
        
        let textLabel = UILabel()
        textLabel.text = """
        
        Results
        
        Leads in individual states may change from one party to another as all the votes are counted. Select a state for detailed results, and select the Senate, House or Governor tabs to view those races.
        
        For more detailed state results
        click on the States A-Z links at the bottom of this page. Results source:
        NEP/Edison via Reuters. 
        
        Leads in individual states may change from one party to another as all the votes are counted. Select a state for detailed results, and select the Senate, House or Governor tabs to view those races.
         
        For more detailed state results
        click on the States A-Z links at the bottom of this page. Results source:
        NEP/Edison via Reuters. 
        
        Leads in individual states may change from one party to another as all the votes are counted. Select a state for detailed results, and select the Senate, House or Governor tabs to view those races.

        
        """
        
        textLabel.numberOfLines = 0
        textLabel.textColor = AppColors.grayDark
        
        let backButton = UIButton(type: .system)
        let backwardImage = UIImage(systemName: "arrow.backward")
        backButton.tintColor = .black
        backButton.setImage(backwardImage, for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
      
        
        
        let favoriteButton = UIButton(type: .system)
        let imageFavorite = UIImage(named: "bookmark")
        favoriteButton.tintColor = .black
        favoriteButton.setImage(imageFavorite, for: .normal)
        favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
        view.addSubview(favoriteButton)
        
        let shareButton = UIButton(type: .system)
        let imageShare =  UIImage(systemName: "arrowshape.turn.up.right")
        shareButton.tintColor = .black
        shareButton.setImage(imageShare, for: .normal)
        shareButton.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
        
        
        let labelCategory = UILabel()
        labelCategory.text = "Politics"
        labelCategory.textColor = .white
        labelCategory.font = .Inter.regular.size(of: 12)
        labelCategory.textAlignment = .center
        labelCategory.layer.cornerRadius = 16
        labelCategory.layer.masksToBounds = true
        labelCategory.backgroundColor = AppColors.purplePrimary
        
        
        let blurEffect = UIBlurEffect(style: .systemChromeMaterialLight)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        
    
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "The latest situation in the presidential election"
        label.textColor = .black
        label.font = .Inter.regular.size(of: 20)
        label.textAlignment = .left
        
        
        let labelAuthor = UILabel()
        labelAuthor.numberOfLines = 0
        labelAuthor.text = "John Doe"
        labelAuthor.textColor = .black
        labelAuthor.font = .Inter.regular.size(of: 16)
        labelAuthor.textAlignment = .left
        
        let labelDefaultAuthor = UILabel()
        labelDefaultAuthor.text = "Autor"
        labelDefaultAuthor.textColor = AppColors.grayLight
        labelDefaultAuthor.font = .Inter.regular.size(of: 14)
        labelDefaultAuthor.textAlignment = .left

        view.addSubview(imageView)
        view.addSubview(scrollView)
        scrollView.addSubview(textLabel)
        view.addSubview(favoriteButton)
        view.addSubview(backButton)
        view.addSubview(shareButton)
        view.addSubview(labelCategory)
        view.addSubview(label)
        view.addSubview(labelAuthor)
        view.addSubview(labelDefaultAuthor)
        imageView.addSubview(blurEffectView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        backButton.translatesAutoresizingMaskIntoConstraints = false
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        labelCategory.translatesAutoresizingMaskIntoConstraints = false
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        labelAuthor.translatesAutoresizingMaskIntoConstraints = false
        labelDefaultAuthor.translatesAutoresizingMaskIntoConstraints = false

        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 324),
            
            scrollView.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -19),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            textLabel.topAnchor.constraint(equalTo: scrollView.topAnchor),
            textLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -19),
            textLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 28),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            favoriteButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 28),
            favoriteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            shareButton.topAnchor.constraint(equalTo: favoriteButton.bottomAnchor, constant: 24),
            shareButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            labelCategory.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 72),
            labelCategory.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            labelCategory.heightAnchor.constraint(equalToConstant: 32),
            labelCategory.widthAnchor.constraint(equalToConstant: 75),
            
            label.topAnchor.constraint(equalTo: labelCategory.bottomAnchor, constant: 16),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            label.heightAnchor.constraint(equalToConstant: 56),
            label.widthAnchor.constraint(equalToConstant: 336),
            
            labelAuthor.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 24),
            labelAuthor.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 26),
            labelAuthor.heightAnchor.constraint(equalToConstant: 24),
            labelAuthor.widthAnchor.constraint(equalToConstant: 74),
            
            labelDefaultAuthor.topAnchor.constraint(equalTo: labelAuthor.bottomAnchor, constant: 4),
            labelDefaultAuthor.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 26),
            labelDefaultAuthor.heightAnchor.constraint(equalToConstant: 24),
            labelDefaultAuthor.widthAnchor.constraint(equalToConstant: 37),
            
            labelAuthor.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 24),
            labelAuthor.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 26),
            labelAuthor.heightAnchor.constraint(equalToConstant: 24),
            labelAuthor.widthAnchor.constraint(equalToConstant: 74),
            
            blurEffectView.topAnchor.constraint(equalTo: imageView.topAnchor),
            blurEffectView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            blurEffectView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            blurEffectView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor)
        ])
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func favoriteButtonTapped() {
        
    }
    
    @objc private func shareButtonTapped() {
        let activityViewController = UIActivityViewController(activityItems: ["Ваше сообщение для обмена"], applicationActivities: nil)
        present(activityViewController, animated: true, completion: nil)
    }
}

