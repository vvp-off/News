//
//  OnboardingViewController.swift
//  WorldNewsApp
//
//  Created by Alexander Bokhulenkov on 28.10.2024.
//

import UIKit

final class OnboardingViewController: UIPageViewController {
    
    // MARK: - Properties
    
    private var onboardingPages = [UIViewController]()
    private let pageControl = UIPageControl()
    private let initialPage = 0
    private var articles: [News] = []
    private let page1 = OnboardingPage1VC()
    private let page2 = OnboardingPage2VC()
    private let page3 = OnboardingPage3VC()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        chooseStartScreen()
        fetchNews(apiService: .technology)
    }
    
    // MARK: - Actions
    
    @objc private func pageControlAction(_ sender: UIPageControl) {
        setViewControllers([onboardingPages[sender.currentPage]], direction: .forward, animated: true)
    }
    
    // MARK: - Methods
    
    private func chooseStartScreen() {
        if UserDefaultsService.shared.isOnboarding {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let sceneDelegate = windowScene.delegate as? SceneDelegate {
                let nextVC = TabBarController()
                sceneDelegate.window?.rootViewController = nextVC
            }
        } else {
            setOnboardingVC()
        }
    }
    
    private func setOnboardingVC() {
        view.addSubview(pageControl)
        setDelegate()
        setOnboardingPages()
        setPageControl()
        setConstraints()
        if !onboardingPages.isEmpty {
            setViewControllers([onboardingPages[initialPage]], direction: .forward, animated: true)
        }
    }
    
    private func setOnboardingPages() {
        onboardingPages.removeAll()
        [page1, page2, page3].forEach {onboardingPages.append($0)}
    }
    
    func fetchNews(apiService: ApiService) {
        let httpClient = HTTPClient(with: .default)
        
        Task {
            do {
                let articles = try await httpClient.requestData(for: apiService)
                self.articles = articles.map {News(from: $0) }
                
                // Здесь обновляем UI с нашими данными.
                DispatchQueue.main.async {
                    //                    self.setOnboardingVC()
                }
                //                удалить потом просто проверка
                for sourse in articles {
                    print(sourse.urlToImage ?? "")
                }
            }
            catch let error as RequestError {
                print("Произошла ошибка: \(error.errorDescription ?? "Неизвестная ошибка")")
            }
        }
    }
    
    private func setDelegate() {
        dataSource = self
        delegate = self
        page1.delegate = self
        page2.delegate = self
    }
    
    private func setPageControl() {
        pageControl.currentPageIndicatorTintColor = AppColors.grayLighter
        pageControl.pageIndicatorTintColor = AppColors.blue
        pageControl.transform = CGAffineTransform(scaleX: 1.5, y: 0.8)
        pageControl.numberOfPages = onboardingPages.count
        pageControl.currentPage = initialPage
        pageControl.addTarget(self, action: #selector(pageControlAction), for: .touchUpInside)
        
        if #available(iOS 14.0, *) {
            pageControl.preferredIndicatorImage = UIImage(systemName: "oval.fill")
        }
    }
}

// MARK: - Extension UIPageViewControllerDataSource

extension OnboardingViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let index = onboardingPages.firstIndex(of: viewController) else { return nil }
        
        return index == 0 ? onboardingPages.last : onboardingPages[index-1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let index = onboardingPages.firstIndex(of: viewController) else { return nil }
        
        return index < (onboardingPages.count - 1) ? onboardingPages[index + 1] : onboardingPages.first
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        onboardingPages.count
    }
}

// MARK: - Extension UIPageViewControllerDelegate

extension OnboardingViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        guard let viewControllers = pageViewController.viewControllers else { return }
        guard let currentIndex = onboardingPages.firstIndex(of: viewControllers[0]) else { return }
        
        pageControl.currentPage = currentIndex
    }
}

// MARK: - Extension UIPageViewController

extension OnboardingViewController: OnboardingDelegate {
    func goToNextPage() {
        guard let currentPage = viewControllers?[0] else { return }
        guard let nextVC = dataSource?.pageViewController(self, viewControllerAfter: currentPage) else { return }
        setViewControllers([nextVC], direction: .forward, animated: true)
        
        if let currentIndex = onboardingPages.firstIndex(of: currentPage) {
            pageControl.currentPage = currentIndex + 1
        }
    }
}

// MARK: - Extension Constraints

extension OnboardingViewController {
    func setConstraints() {
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pageControl.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            pageControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            pageControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
}
