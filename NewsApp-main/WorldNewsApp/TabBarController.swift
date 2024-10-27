//
//  TabBarController.swift
//  NewsToDay
//
//  Created by vp.off on 22.10.2024.
//

import UIKit

class CustomTabBar: UITabBar {
    
    private let tabBarHeight: CGFloat = 96
    private let borderColor = CGColor(red: 172/255, green: 175/255, blue: 195/255, alpha: 0.32)
    private let cornerRadiusFactor: CGFloat = 12
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureTabBarFrame()
        adjustItemTitlePosition()
        styleTabBar()
    }
    
    private func configureTabBarFrame() {
        self.frame.size.height = tabBarHeight
        self.frame.origin.y = self.superview!.frame.height - tabBarHeight
    }
    
    private func adjustItemTitlePosition() {
        let verticalAdjustment = -(tabBarHeight - 49) / 2
        for item in self.items ?? [] {
            item.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: verticalAdjustment)
        }
    }
    
    private func styleTabBar() {
        self.layer.cornerRadius = tabBarHeight / cornerRadiusFactor
        self.layer.masksToBounds = true
        self.backgroundColor = .white
        self.layer.borderWidth = 1
        self.layer.borderColor = borderColor
    }
}

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
        let customTabBar = CustomTabBar()
        self.setValue(customTabBar, forKey: "tabBar")
        configureTabBarAppearance()
    }
    
    private func setupTabs() {
        let viewControllers = [
            createViewController(HomeViewController(), imageName: "home"),
            createViewController(AppsViewController(), imageName: "apps"),
            createViewController(BookmarkViewController(), imageName: "bookmark"),
            createViewController(UserViewController(), imageName: "user")
        ]
        setViewControllers(viewControllers, animated: false)
    }
    
    private func createViewController(_ viewController: UIViewController, imageName: String) -> UIViewController {
        viewController.tabBarItem.image = UIImage(named: imageName)
        return viewController
    }
    
    private func configureTabBarAppearance() {
        UITabBar.appearance().tintColor = UIColor(red: 71/255, green: 90/255, blue: 215/255, alpha: 1)
    }
}
