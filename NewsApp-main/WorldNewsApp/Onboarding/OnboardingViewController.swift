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
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        setOnboardingVC()
        
        setPageControl()
    }
    
    // MARK: - Actions
    
    @objc private func pageControlAction(_ sender: UIPageControl) {
        setViewControllers([onboardingPages[sender.currentPage]], direction: .forward, animated: true)
    }
    
    // MARK: - Methods
    
    private func setOnboardingVC() {
        let page1 = OnboardingPage1VC()
        let page2 = OnboardingPage2VC()
        let page3 = OnboardingPage3VC()
        
        [page1, page2, page3].forEach {onboardingPages.append($0)}
        view.addSubview(pageControl)
        
        setViewControllers([onboardingPages[initialPage]], direction: .forward, animated: true)
    }
    
    private func setDelegate() {
        dataSource = self
        delegate = self
    }
    
    private func setPageControl() {
        pageControl.currentPageIndicatorTintColor = .systemGray
        pageControl.pageIndicatorTintColor = .systemBlue
        pageControl.numberOfPages = onboardingPages.count
        pageControl.currentPage = initialPage
        
        pageControl.addTarget(self, action: #selector(pageControlAction), for: .touchUpInside)
        
        if #available(iOS 14.0, *) {
            pageControl.preferredIndicatorImage = UIImage(systemName: "oval.fill")
        }
        
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
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
