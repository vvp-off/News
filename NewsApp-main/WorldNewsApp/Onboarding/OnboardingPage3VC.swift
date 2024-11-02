//
//  OnboardingPage3VC.swift
//  WorldNewsApp
//
//  Created by Alexander Bokhulenkov on 28.10.2024.
//

import UIKit

final class OnboardingPage3VC: UIViewController {
    
    // MARK: - Properties
    
    let transitionManager = TransitionManager()
    
    private let imageView = ImageFactory.makeOnboardingImage(name: K.page3Image)
    private let titleLabel = LabelFactory.createTitleLabel(with: K.titleNews.page3.rawValue)
    private let subtitleLabel = LabelFactory.createSubtitleLabel(with: K.page3Description)
    private let startedButton = ButtonFactory.makeButtonWithText(text: "Get Started")
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setVC()
        setConstraints()
    }
    
    // MARK: - Actions
    
    @objc private func startedButtonAction(_ sender: UIButton) {
        presentingController()
        UserDefaultsService.shared.isOnboarding = true
    }
    
    private func presentingController() {
        let nextVC = TabBarController()
        nextVC.modalPresentationStyle = .custom
        nextVC.transitioningDelegate = self
        present(nextVC, animated: true)
    }
    
    // MARK: - Methods
    
    private func setVC() {
        [
            imageView,
            titleLabel,
            subtitleLabel,
            startedButton
        ].forEach { view.addSubview($0) }
        
        startedButton.addTarget(self, action: #selector(startedButtonAction), for: .touchUpInside)
    }
}

// MARK: - Extensions UIViewControllerTransitioningDelegate

extension OnboardingPage3VC: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return transitionManager
    }
}

// MARK: - Extensions Constraints

extension OnboardingPage3VC {
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
            
            startedButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            startedButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            startedButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            startedButton.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
}

final class UserDefaultsService {
    static let shared = UserDefaultsService()
    
    private init(){}
    
    var isOnboarding: Bool {
        get { UserDefaults.standard.bool(forKey: "isOnboarding") }
        set { UserDefaults.standard.set(newValue, forKey: "isOnboarding")}
    }
}
