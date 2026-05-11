
//
//  ViewController.swift
//  SportsApp
//
//  Created by Eyad waleed on 04/05/2026.
//

import UIKit

class TeamsViewController: UIViewController {
    
    private let headerHeight  = 32
    private let customeBannerKind = "BannerKind"
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setupCollectionView()
       setupLayout()
    }
    func setupCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        registerCells()
        registerTopBanner()
        registerHeader()
        
    }
    func setupLayout (){
        setCollectionViewlayout(layout: createCompositionalLayout())
    }
    // register cells , TopBanner & headers
    func registerCells(){

        registerUpcomingCell()
        retgisterTeamCell()
       registerLatestResultCell()
        
    }
    func registerUpcomingCell(){
        
        self.collectionView.register(UINib(nibName: Constant.upcomingCellNibName, bundle: nil), forCellWithReuseIdentifier: Constant.upcomingCellIdentifer)
        
    }
    func retgisterTeamCell(){
        
        self.collectionView.register(UINib(nibName: Constant.teamCellNibName, bundle: nil), forCellWithReuseIdentifier: Constant.teamResultCellIdentifer)
        
    }
    func registerLatestResultCell(){
        self.collectionView.register(UINib(nibName: Constant.latestResultCellNibName, bundle: nil), forCellWithReuseIdentifier: Constant.latestResultCellIdentifer)
    }
    func registerTopBanner(){
        collectionView.register(
            UINib(nibName: Constant.topBannerNibName, bundle: nil),
            forSupplementaryViewOfKind: self.customeBannerKind,
            withReuseIdentifier: Constant.topBannerIdentifer
        )
    }
    func registerHeader(){
        collectionView.register(
            UINib(nibName: Constant.headerNibName, bundle: nil),
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: Constant.headeridentifer
        )
    }
    // create the CompotionalLayout
    func createCompositionalLayout() -> UICollectionViewCompositionalLayout{
        let layout = UICollectionViewCompositionalLayout{
            index , enviroment in
            switch index {
            case 0 :
                return self.drawUpcomingSection()
            case 1 :
                return self.drawTeamsSection()
            default :
                return self.drawLatestResult()
            }
        }
        layout.configuration = createGlobalBanner()
        return layout
        
    }
    
    func createGlobalBanner()-> UICollectionViewCompositionalLayoutConfiguration
    {
        let bannerSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(190)
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
        collectionView.setCollectionViewLayout(layout, animated: true)
    }
    // creation of each section
    func  drawUpcomingSection() ->NSCollectionLayoutSection{
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
    func drawTeamsSection() ->NSCollectionLayoutSection{
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
    func drawLatestResult()->NSCollectionLayoutSection{
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
    func drawItem() -> NSCollectionLayoutItem {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1) )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        return item
        
    }
    func drawGroup(width :CGFloat , height :CGFloat ) -> NSCollectionLayoutGroup {
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(width), heightDimension: .absolute(height))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [drawItem()])
    return group
    }
    
}
extension TeamsViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == self.customeBannerKind {
               let banner = collectionView.dequeueReusableSupplementaryView(
                   ofKind: kind,
                   withReuseIdentifier: Constant.topBannerIdentifer,
                   for: indexPath
               ) as! TopBanner
               return banner
               
           } else {
               let titles = ["Upcoming Eventes", "Teams", "Latest Results"]
               let icons  :[UIImage] = [UIImage(systemName:"calendar")!,
                                        UIImage(systemName:"person.3.fill")!,
                                        UIImage(systemName:"clock.arrow.circlepath")!]
               let header = collectionView.dequeueReusableSupplementaryView(
                   ofKind: kind,
                   withReuseIdentifier: Constant.headeridentifer,
                   for: indexPath
               ) as! LeagueDetailsCustomeHeader
               header.configure(headerName: titles[indexPath.section], icon:icons[indexPath.section] )
               return header
           }
    }
    
}
extension TeamsViewController : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0 :
            return createUpcomingMatchCell(indexPath: indexPath)
        case 1 :
            return createTeamsCell(indexPath: indexPath)
            
        default :
            return creatLatestResultCell(index: indexPath)
        }}
    
    func createUpcomingMatchCell(indexPath:IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Constant.upcomingCellIdentifer,
            for: indexPath
        ) as! UpcomingCollectionViewCell
     
        return cell
    }
    func createTeamsCell(indexPath:IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Constant.teamResultCellIdentifer,
            for: indexPath
        ) as! TeamsCollectionViewCell
     
        return cell
    }
    func creatLatestResultCell(index:IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Constant.latestResultCellIdentifer,
            for: index
        ) as! LatestResultCollectionViewCell
     
        return cell
    }
}
