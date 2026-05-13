//
//  LeagueDetailsLayoutFactory.swift
//  SportsApp
//
//  Created by Eyad waleed on 10/05/2026.
//

import Foundation
import UIKit
struct LeagueDetailsLayoutFactory {
   static private let headerHeight  = 32
    static  let customeBannerKind = "BannerKind"
    static func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { index, environment in
            
          
            
            switch index {
            case 0: return drawUpcomingSection()
            case 1: return drawTeamsSection()
            default: return drawLatestResult()
            }
        }
        layout.configuration = createGlobalBanner()
        return layout
    }
    
  static   func createGlobalBanner()-> UICollectionViewCompositionalLayoutConfiguration
    {
        let bannerSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(200)
            )
        
            let banner = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: bannerSize,
                elementKind: self.customeBannerKind,
                alignment: .top
            )
        banner.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 8, bottom:4 , trailing: 8)
            
            let config = UICollectionViewCompositionalLayoutConfiguration()
            config.boundarySupplementaryItems = [banner]
        return config
    }
    
static    func  drawUpcomingSection() ->NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1) )
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.6), heightDimension: .absolute(120))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 8, bottom:4 , trailing: 8)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let seciton = NSCollectionLayoutSection(group:group)
        seciton.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
        seciton.orthogonalScrollingBehavior = .continuous
        let headerSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(CGFloat(self.headerHeight))
            )
            let header = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )
            seciton.boundarySupplementaryItems = [header]
        return seciton
    }
 static   func drawTeamsSection() ->NSCollectionLayoutSection{
        let seciton = NSCollectionLayoutSection(group: drawGroup(width: 0.3, height: 100))
        seciton.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
        seciton.orthogonalScrollingBehavior = .continuous
        let headerSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(CGFloat(self.headerHeight))
            )
            let header = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )
            seciton.boundarySupplementaryItems = [header]
        return seciton
    }
 static   func drawLatestResult()->NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1) )
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(125))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom:8 , trailing: 8)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let seciton = NSCollectionLayoutSection(group:group)
        seciton.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)

        let headerSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(CGFloat(self.headerHeight))
            )
            let header = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )
            seciton.boundarySupplementaryItems = [header]
        return seciton
    }
 static   func drawItem() -> NSCollectionLayoutItem {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1) )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        return item
        
    }
  static  func drawGroup(width :CGFloat , height :CGFloat ) -> NSCollectionLayoutGroup {
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(width), heightDimension: .absolute(height))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [drawItem()])
    return group
    }
}
