//
//  ClubViewController.swift
//  SportsApp
//
//  Created by Eyad waleed on 06/05/2026.
//

import UIKit

class ClubViewController: UIViewController {
    private let customeBannerKind = "topBannerTeam"
    private let headerHeight = 32

    @IBOutlet weak var clubCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
    }
    
    func setUpCollectionView(){
        self.clubCollectionView.delegate = self
        self.clubCollectionView.dataSource = self
        setUpCells()
        registerTopBanner()
        registerHeaders()
        setupLayout()
    }
    func setUpCells(){
        registerCoachCell()
        registerPlayersCell()
       
    }
     
    func registerCoachCell(){
        self.clubCollectionView.register(UINib(nibName:Constant.coachCellNibName , bundle: nil), forCellWithReuseIdentifier: Constant.coachIdentifer)

    }
    func registerPlayersCell(){
        self.clubCollectionView.register(UINib(nibName: Constant.playerCellNibName, bundle: nil), forCellWithReuseIdentifier: Constant.playerIdentifer)
    }
    
    func registerTopBanner(){
        clubCollectionView.register(
            UINib(nibName: Constant.topBannerTeamNibName, bundle: nil),
            forSupplementaryViewOfKind: self.customeBannerKind,
            withReuseIdentifier: Constant.topBannerTeamIdentifer
        )
    }
    
    func registerHeaders(){
        clubCollectionView.register(
            UINib(nibName: Constant.headerNibName, bundle: nil),
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: Constant.headeridentifer
        )
    }
    func setupLayout (){
        setCollectionViewlayout(layout: createCompositionalLayout())
    }
  
    func createCompositionalLayout() -> UICollectionViewCompositionalLayout{
        let layout = UICollectionViewCompositionalLayout{
            index , enviroment in
            switch index {
            case 0 :
                return self.drawCoachSection()
            default :
                return self.drawPlayersSection()
            }
        }
        layout.configuration = createGlobalBanner()
        return layout
        
    }
    
    func createGlobalBanner()-> UICollectionViewCompositionalLayoutConfiguration
    {
        let bannerSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(272)
            )
            let banner = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: bannerSize,
                elementKind: self.customeBannerKind,
                alignment: .top
            )
            
            let config = UICollectionViewCompositionalLayoutConfiguration()
            config.boundarySupplementaryItems = [banner]
        return config
    }
    
    func setCollectionViewlayout( layout:UICollectionViewCompositionalLayout){
        clubCollectionView.setCollectionViewLayout(layout, animated: true)
    }
    
    func drawCoachSection() -> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1) )
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.6), heightDimension: .absolute(282))
        
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
    func drawPlayersSection() -> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1) )
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.6), heightDimension: .absolute(270))
        
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
}
extension ClubViewController : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == self.customeBannerKind {
               let banner = collectionView.dequeueReusableSupplementaryView(
                   ofKind: kind,
                   withReuseIdentifier: Constant.topBannerTeamIdentifer,
                   for: indexPath
               ) as! TopBannerTeamReusableView
               return banner
               
           } else {
               let titles = [ "Coaches", "Players"]
               let icons  :[UIImage] = [UIImage(systemName:"person.fill")!,
                                        UIImage(systemName:"person.3.fill")!,
                                       ]
               let header = collectionView.dequeueReusableSupplementaryView(
                   ofKind: kind,
                   withReuseIdentifier: Constant.headeridentifer,
                   for: indexPath
               ) as! HeaderReusableView
               header.configure(headerName: titles[indexPath.section], icon:icons[indexPath.section] )
               return header
           }
    }
    
}
extension ClubViewController :UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0 :
            return dequeueCoachCell(indexPath: indexPath)
        
            
        default :
            return dequeuePlayerCell(indexPath: indexPath)
        }}
    
    func dequeueCoachCell (indexPath:IndexPath) -> UICollectionViewCell{
        let cell = clubCollectionView.dequeueReusableCell(
            withReuseIdentifier: Constant.coachIdentifer,
            for: indexPath
        ) as! CoachesCollectionViewCell
     
        return cell
    }
    func dequeuePlayerCell(indexPath:IndexPath) ->UICollectionViewCell{
        let cell = clubCollectionView.dequeueReusableCell(
            withReuseIdentifier: Constant.playerIdentifer,
            for: indexPath
        ) as! PlayerCollectionViewCell
     
        return cell
        
    }
    
    
}
