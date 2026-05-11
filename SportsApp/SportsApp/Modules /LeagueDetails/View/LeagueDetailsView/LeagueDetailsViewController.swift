//
//  ViewController.swift
//  SportsApp
//
//  Created by Eyad waleed on 04/05/2026.
//

import UIKit
import SDWebImage
protocol LeagueDetailsViewControllerProtcol : AnyObject{
    func startAnimating()
    func stopAnimating()
}
class LeagueDetailsViewController: UIViewController {
    @IBOutlet weak var loadingIndecator: UIActivityIndicatorView!
    private var presenetr : LeagueDetailsPresenterProtocol!
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        presenetr = LeagueDetailsPresenter(apiData: EventServices() )
        presenetr.getView(view: self)
        presenetr .fetchData()
        setupCollectionView()
        setCollectionViewlayout()
    }
    func setupCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        registerToCollectionView()
   
    }
     func setCollectionViewlayout(){
         let layout = LeagueDetailsLayoutFactory.createCompositionalLayout()
         collectionView.setCollectionViewLayout(layout, animated: true)
     }
    func registerToCollectionView(){
        registerCells()
        registerHeaders()
        registerTopBanner()
    }
    func registerCells(){
        
        self.collectionView.register(UINib(nibName: Constant.upcomingCellNibName, bundle: nil), forCellWithReuseIdentifier: Constant.upcomingCellIdentifer)
        
        self.collectionView.register(UINib(nibName: Constant.teamCellNibName, bundle: nil), forCellWithReuseIdentifier: Constant.teamResultCellIdentifer)
        
        self.collectionView.register(UINib(nibName: Constant.latestResultCellNibName, bundle: nil), forCellWithReuseIdentifier: Constant.latestResultCellIdentifer)
        
        self.collectionView.register(UINib(nibName: Constant.latestResultCellNibName, bundle: nil), forCellWithReuseIdentifier: Constant.latestResultCellIdentifer)
        
    
        
    }
    func registerHeaders(){
        collectionView.register(
            UINib(nibName: Constant.headerNibName, bundle: nil),
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: Constant.headeridentifer
        )
    }
    func registerTopBanner(){
        collectionView.register(
            UINib(nibName: Constant.topBannerNibName, bundle: nil),
            forSupplementaryViewOfKind:LeagueDetailsLayoutFactory.customeBannerKind,
            withReuseIdentifier: Constant.topBannerIdentifer
        )
    }
}
extension LeagueDetailsViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == LeagueDetailsLayoutFactory.customeBannerKind {
               let banner = collectionView.dequeueReusableSupplementaryView(
                   ofKind: kind,
                   withReuseIdentifier: Constant.topBannerIdentifer,
                   for: indexPath
               ) as! TopBanner
            
            if let event = presenetr?.loadUpcomingMatchesCellData(indexPath:0) {
                banner.configure(leagueName:event.leagueName ?? "", leagueLogo: event.leagueLogo ?? "")
            }
               return banner
               
           } else {

               let header = collectionView.dequeueReusableSupplementaryView(
                   ofKind: kind,
                   withReuseIdentifier: Constant.headeridentifer,
                   for: indexPath
               ) as! LeagueDetailsCustomeHeader
            
               if let section = LeagueDetailsSection(rawValue: indexPath.section) {
                   header.configure(headerName: section.title, icon: section.icon)
               }
        
               return header
           }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           switch indexPath.section {
           case 1:
               guard let team = presenetr?.loadTeams(indexPath: indexPath.item) else { return }
               navigateToTeamDetails(team: team)
           default:
               break
           }
       }
       
       private func navigateToTeamDetails(team: Team) {
           let storyboard = UIStoryboard(name: "Main", bundle: nil)
           let vc = storyboard.instantiateViewController(withIdentifier: Constant.clubViewControllerIdenitfer) as! ClubViewController
           vc.team = team
           navigationController?.pushViewController(vc, animated: true)
       }
    
}
extension LeagueDetailsViewController : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch LeagueDetailsSection(rawValue: indexPath.section) {
        case .upcomingMatches :
            return createUpcomingMatchCell(indexPath: indexPath)
        case .teams :
            return createTeamsCell(indexPath: indexPath)
            
        default :
            return creatLatestResultCell(index: indexPath)
        }}
    
    func createUpcomingMatchCell(indexPath:IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Constant.upcomingCellIdentifer,
            for: indexPath
        ) as! UpcomingCollectionViewCell
    
        if let event = presenetr?.loadUpcomingMatchesCellData(indexPath: indexPath.item) {
            cell.configure(with: event)
        }
        return cell
    }
    func createTeamsCell(indexPath:IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Constant.teamResultCellIdentifer,
            for: indexPath
        ) as! TeamsCollectionViewCell
        
        if let team = presenetr?.loadTeams(indexPath: indexPath.item){
            cell.teamImage.sd_setImage(with: URL(string:team.teamLogo ?? ""),placeholderImage: UIImage(named: "stadium"))
            cell.teamName.text =  team.teamName
            
        }

        return cell
    }
    func creatLatestResultCell(index:IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Constant.latestResultCellIdentifer,
            for: index
        ) as! LatestResultCollectionViewCell
        if let event = presenetr?.loadPlayedMatchesCellData(indexPath: index.item){
            cell.configure(with: event)
            }
        return cell

        }
    
    
    
    
}
extension LeagueDetailsViewController : LeagueDetailsViewControllerProtcol{
    func startAnimating() {
        self.loadingIndecator.isHidden = false
        self.loadingIndecator.startAnimating()
        self.collectionView.isHidden = true
    }
    func stopAnimating() {
        self.loadingIndecator.isHidden = true
        self.loadingIndecator.stopAnimating()
        self.collectionView.isHidden = false
        self.collectionView.reloadData()
    }
    
    
}
enum LeagueDetailsSection: Int, CaseIterable {
    case upcomingMatches
    case teams
    case latestResults
    
    var title: String {
        switch self {
        case .upcomingMatches: return "Upcoming Events"
        case .teams:           return "Teams"
        case .latestResults:   return "Latest Results"
        }
    }

    var icon: UIImage {
        switch self {
        case .upcomingMatches: return UIImage(systemName: "calendar") ?? UIImage()
        case .teams:           return UIImage(systemName: "person.3.fill") ?? UIImage()
        case .latestResults:   return UIImage(systemName: "clock.arrow.circlepath") ?? UIImage()
        }
    }
}
