//
//  Result.swift
//  WorldNewsApp
//
//  Created by vp.off on 27.10.2024.
//
import Kingfisher
import UIKit

class PaddingLabel: UILabel {
    var textInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)

    override func drawText(in rect: CGRect) {
        let paddedRect = rect.inset(by: textInsets)
        super.drawText(in: paddedRect)
    }

    override var intrinsicContentSize: CGSize {
        let intrinsicContentSize = super.intrinsicContentSize
        let width = intrinsicContentSize.width + textInsets.left + textInsets.right
        let height = intrinsicContentSize.height + textInsets.top + textInsets.bottom
        return CGSize(width: width, height: height)
    }
}

class ResultViewController: UIViewController {
    private var isFavorite: Bool = false
    
    private var article: News?
    
    init (with article: News? = nil) {
        self.article = article
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUII()
    }
    
    var favoriteButton = UIButton(type: .system)
    let imageFavorite = UIImage(named: "bookmark")
    
    func setupUII() {
        
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        guard let stringImage = article?.urlToImage else {return}
        let urlImage = URL(string: stringImage)
        if let image = urlImage {
            imageView.kf.setImage(with: image)
        } else {
            imageView.image = UIImage(named: "tempImage")
        }
        
        let dimmingView = UIView(frame: imageView.bounds)
        dimmingView.backgroundColor = UIColor.black.hex(0x22242F).withAlphaComponent(0.48)
        
        
        let scrollView = UIScrollView()
        
        
        let textLabel = UILabel()
        textLabel.text = article?.content
        
        textLabel.numberOfLines = 0
        textLabel.textColor = AppColors.grayDark
        
        let backButton = UIButton(type: .system)
        let backwardImage = UIImage(systemName: "arrow.backward")
        backButton.tintColor = .white
        backButton.setImage(backwardImage, for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        favoriteButton.tintColor = .white
        favoriteButton.setImage(imageFavorite, for: .normal)
        favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
        
        let shareButton = UIButton(type: .system)
        let imageShare =  UIImage(systemName: "arrowshape.turn.up.right")
        shareButton.tintColor = .white
        shareButton.setImage(imageShare, for: .normal)
        shareButton.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
        
        let labelCategory = PaddingLabel()
        labelCategory.text = article?.sourceName
        labelCategory.textColor = .white
        labelCategory.font = .Inter.regular.size(of: 12)
        labelCategory.textAlignment = .center
        labelCategory.layer.cornerRadius = 16
        labelCategory.layer.masksToBounds = true
        labelCategory.backgroundColor = AppColors.purplePrimary
        
        let label = UILabel()
        label.numberOfLines = 0
        label.text = article?.title
        label.textColor = .white
        label.font = .Inter.regular.size(of: 20)
        label.textAlignment = .left
        
        let labelAuthor = UILabel()
        labelAuthor.numberOfLines = 0
        labelAuthor.text = article?.author
        labelAuthor.textColor = .white
        labelAuthor.font = .Inter.regular.size(of: 16)
        labelAuthor.textAlignment = .left
        
        let labelDefaultAuthor = UILabel()
        labelDefaultAuthor.text = "Autor"
        labelDefaultAuthor.textColor = AppColors.grayLight
        labelDefaultAuthor.font = .Inter.regular.size(of: 14)
        labelDefaultAuthor.textAlignment = .left
        
        view.addSubview(imageView)
        imageView.addSubview(dimmingView)
        view.addSubview(scrollView)
        scrollView.addSubview(textLabel)
        view.addSubview(favoriteButton)
        view.addSubview(backButton)
        view.addSubview(shareButton)
        view.addSubview(labelCategory)
        view.addSubview(label)
        view.addSubview(labelAuthor)
        view.addSubview(labelDefaultAuthor)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        backButton.translatesAutoresizingMaskIntoConstraints = false
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        labelCategory.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        labelAuthor.translatesAutoresizingMaskIntoConstraints = false
        labelDefaultAuthor.translatesAutoresizingMaskIntoConstraints = false
        dimmingView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 324),
            
            dimmingView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            dimmingView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            dimmingView.topAnchor.constraint(equalTo: imageView.topAnchor),
            dimmingView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
            
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
            
            label.topAnchor.constraint(equalTo: labelCategory.bottomAnchor, constant: 16),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            label.heightAnchor.constraint(equalToConstant: 56),
            label.widthAnchor.constraint(equalToConstant: 336),
            
            labelAuthor.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 24),
            labelAuthor.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 26),
            labelAuthor.heightAnchor.constraint(equalToConstant: 24),
            
            labelDefaultAuthor.topAnchor.constraint(equalTo: labelAuthor.bottomAnchor, constant: 4),
            labelDefaultAuthor.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 26),
            labelDefaultAuthor.heightAnchor.constraint(equalToConstant: 24),
            labelDefaultAuthor.widthAnchor.constraint(equalToConstant: 37),
        ])
        
    }
    
    @objc private func backButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc private func favoriteButtonTapped() {
       if isFavorite == false {
           favoriteButton.setBackgroundImage(UIImage(systemName: "bookmark.fill"), for: .normal)
           favoriteButton.tintColor = AppColors.purplePrimary
           isFavorite = true
        } else {
            favoriteButton.setBackgroundImage(UIImage(systemName: "bookmark"), for: .normal)
            favoriteButton.tintColor = .white
            isFavorite = false
        }
    }
        
        @objc private func shareButtonTapped() {
            let activityViewController = UIActivityViewController(activityItems: ["Ваше сообщение для обмена"], applicationActivities: nil)
            present(activityViewController, animated: true, completion: nil)
        }
    }
