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
    func reloadView()
    func setupFavoriteButton()
    
}
class LeagueDetailsViewController: UIViewController {
    @IBOutlet weak var loadingIndecator: UIActivityIndicatorView!
    private var presenetr : LeagueDetailsPresenterProtocol!
    @IBOutlet weak var collectionView: UICollectionView!
    var league :League!
    var sport: Sport = APIConfig.endpoint 
    override func viewDidLoad() {
        super.viewDidLoad()
        presenetr = LeagueDetailsPresenter(apiData: FixturesDataImp(), sport: sport)
//        presenetr = LeagueDetailsPresenter(apiData: FixturesDataImp() )
        presenetr.getView(view: self)
        presenetr .fetchData(leagueId: Int(league!.league_key ?? 177))
        setupCollectionView()
        setCollectionViewlayout()
    }
    func setupFavoriteButton() {
        let isFav = CoreDataManager.shared.isLeagueFavorite(leagueId: league.league_key ?? 0)
        let starIcon = isFav ? "star.fill" : "star"
        let starButton = UIBarButtonItem(
            image: UIImage(systemName: starIcon),
            style: .plain,
            target: self,
            action: #selector(toggleFavorite)
        )
        starButton.tintColor = .systemYellow
        navigationItem.rightBarButtonItem = starButton
    }
    @objc func toggleFavorite() {
        let leagueId = league.league_key ?? 0
        
        if CoreDataManager.shared.isLeagueFavorite(leagueId: leagueId) {
            CoreDataManager.shared.deleteLeague(leagueId: leagueId)
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: "star")
        } else {
            CoreDataManager.shared.saveLeague(
                leagueId: leagueId,
                leagueName: league.league_name ?? "",
                leagueBadge: league.league_logo ?? "",
                sportName: sport.rawValue.replacingOccurrences(of: "/", with: "")

//                sportName: APIConfig.endpoint.rawValue.replacingOccurrences(of: "/", with: "")
            )
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: "star.fill")
        }
    }
    func setupCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        registerToCollectionView()
   
    }
     func setCollectionViewlayout(){
         let layout = LeagueDetailsLayoutFactory.createCompositionalLayout( )
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
        
        self.collectionView.register(UINib(nibName: Constant.errorCellNibName, bundle: nil), forCellWithReuseIdentifier: Constant.errorCellIdentifier)
        
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
            
            banner.configure(leagueName: league!.league_name ?? "Unknown" , leagueLogo: league!.league_logo ?? "" )
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
        let vc = storyboard.instantiateViewController(withIdentifier: Constant.clubIdentifer) as! ClubViewController
           vc.team = team
           navigationController?.pushViewController(vc, animated: true)
       }
    
}
extension LeagueDetailsViewController : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        switch LeagueDetailsSection(rawValue: section ) {
        case .upcomingMatches :
            let length = presenetr.getUpcomingEventCount()
            print(length)
            guard length  !=  0 else {
                return 1
            }
            return length
        case .latestResults :
            let length = presenetr.getLatestEventCount()
            guard length  !=  0 else {
                return 1
            }
            return length
        default :
            let length = presenetr.getTeamsCount()
            guard length  !=  0 else {
                return 1
            }
            return length
        }
  

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch LeagueDetailsSection(rawValue: indexPath.section) {
        case .upcomingMatches :
            return presenetr.getUpcomingEventCount() == 0 ? createErrorCell(indexPath: indexPath, message: "There is no upcoming events") : createUpcomingMatchCell(indexPath: indexPath)
            
        case .teams :
            return presenetr.getTeamsCount() == 0 ? createErrorCell(indexPath: indexPath, message: "There is no Teams") : createTeamsCell(indexPath: indexPath)
            
        default :
            return presenetr.getLatestEventCount() == 0 ? createErrorCell(indexPath: indexPath, message: "There is no played matches") : creatLatestResultCell(index: indexPath)
        }}
    // creation of item in each cell
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
    func createErrorCell(indexPath: IndexPath, message: String) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Constant.errorCellIdentifier,
            for: indexPath
        ) as! ErrorCell
        cell.config(message: message)
        
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
        print("Hello I'm stop ")
    }
 
    func reloadView(){
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
