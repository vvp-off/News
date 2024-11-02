//
//  OnboardingPage2VC.swift
//  WorldNewsApp
//
//  Created by Alexander Bokhulenkov on 28.10.2024.
//

import UIKit

final class OnboardingPage2VC: UIViewController {
    
    // MARK: - Properties
    
    weak var delegate: OnboardingDelegate?
    var articles: [News] = []
    
    private let imageView = ImageFactory.makeOnboardingImage(name: K.page2Image)
    private let titleLabel = LabelFactory.createTitleLabel(with: K.titleNews.page2.rawValue)
    private let subtitleLabel = LabelFactory.createSubtitleLabel(with: K.page2Description)
    private let nextButton = ButtonFactory.makeButtonWithText(text: "Next")
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setVC()
        setConstraints()
    }
    
    // MARK: - Actions
    
    @objc private func nextButtonAction(_ sender: UIButton) {
        delegate?.goToNextPage()
    }
    
    // MARK: - Methods
    
    private func setVC() {
        [
            imageView,
            titleLabel,
            subtitleLabel,
            nextButton
        ].forEach { view.addSubview($0) }
        
        nextButton.addTarget(self, action: #selector(nextButtonAction), for: .touchUpInside)
    }
}

// MARK: - Extensions Constraints

extension OnboardingPage2VC {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1.15),
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 60),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
            subtitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
            
            nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nextButton.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
}
