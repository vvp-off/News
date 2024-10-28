//
//  UICollectionViewLayout + ext.swift
//  WorldNewsApp
//
//  Created by Igor Guryan on 26.10.2024.
//

import UIKit.UICollectionViewLayout

extension UICollectionViewLayout {
    static func newsLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            switch NewsSection(rawValue: sectionIndex) {
            case .categories:
                return createCategorySection()
            case .newsFromCategory:
                return createNewsFromCategorySection()
            case .recommendedNews:
                return createRecommendedFromCategorySection()
            default:
                return nil
            }
        }
        return layout
    }
    
    private static func createCategorySection() -> NSCollectionLayoutSection {
        let estimatedHeight: CGFloat = 32
        let estimatedWidth: CGFloat = 86
        let size = NSCollectionLayoutSize(widthDimension: .estimated(estimatedWidth),
                                          heightDimension: .estimated(estimatedHeight))
        let item = NSCollectionLayoutItem(layoutSize: size)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: size,
                                                       subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 8
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 12)
        
        //        let header = createHeader()
        //        section.boundarySupplementaryItems = [header]
        return section
    }
    
    private static func createNewsFromCategorySection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 12)
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(256), heightDimension: .absolute(256))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 12.0, leading: 12.0, bottom: 48.0, trailing: 12.0)
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        return section
    }
    
    private static func createRecommendedFromCategorySection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(96))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 12.0, leading: 12.0, bottom: 12.0, trailing: 12.0)
        section.interGroupSpacing = 8
        //        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        let header = createHeader()
        section.boundarySupplementaryItems = [header]
        return section
    }
    
    private static func createHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(40))
        let layout = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: itemSize,
                                                                 elementKind: UICollectionView.elementKindSectionHeader,
                                                                 alignment: .top)
        return layout
    }
    
}
