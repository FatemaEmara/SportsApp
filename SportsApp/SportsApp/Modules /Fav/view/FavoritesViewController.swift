//
//  FavoritesViewController.swift
//  SportsApp
//
//  Created by Fatema Emara on 06/05/2026.
//

import UIKit

protocol FavoritesViewProtocol: AnyObject {
    func reloadData()
    func showNoInternetAlert()
}
class FavoritesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var presenter: FavoritesPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = FavoritesPresenter(view: self)
        setupBackground()
        setupNavigationBar()
        setupTableView()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(internetRestored),
            name: .internetConnected,
            object: nil
        )
      
    }
    

    @objc func internetRestored() {
        presenter.loadFavorites()
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.loadFavorites()
    }
    
    func setupBackground() {
        view.backgroundColor = UIColor(red: 0.05, green: 0.1, blue: 0.16, alpha: 1)
    }
    
    func setupNavigationBar() {
        title = "Favorites"
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(red: 0.05, green: 0.1, blue: 0.16, alpha: 1)
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    func setupTableView() {
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(LeagueCell.self, forCellReuseIdentifier: "LeagueCell")
        tableView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
    }
}

// MARK: - FavoritesViewProtocol
extension FavoritesViewController: FavoritesViewProtocol {
    
    func reloadData() {
        tableView.reloadData()
        
        if presenter.favoritesCount == 0 {
            setupEmptyState()
            tableView.separatorStyle = .none
        } else {
            tableView.backgroundView = nil
        }
    }
    
    func showNoInternetAlert() {

        let alert = UIAlertController(
            title: "No Internet Connection",
            message: "Please reconnect to continue.",
            preferredStyle: .alert
        )

        alert.addAction(UIAlertAction(
            title: "OK",
            style: .default
        ))

        present(alert, animated: true)
    }

func setupEmptyState() {
    let emptyView = UIView()
    emptyView.tag = 999
    
    let imageView = UIImageView()
    imageView.image = UIImage(systemName: "star.slash")
    imageView.tintColor = UIColor.white.withAlphaComponent(0.3)
    imageView.contentMode = .scaleAspectFit
    imageView.translatesAutoresizingMaskIntoConstraints = false
    
    let titleLabel = UILabel()
    titleLabel.text = "No Favorites Yet"
    titleLabel.textColor = .white
    titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
    titleLabel.textAlignment = .center
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    
    let subtitleLabel = UILabel()
    subtitleLabel.text = "Leagues you save will appear here"
    subtitleLabel.textColor = UIColor.white.withAlphaComponent(0.5)
    subtitleLabel.font = UIFont.systemFont(ofSize: 15)
    subtitleLabel.textAlignment = .center
    subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
    
    let stack = UIStackView(arrangedSubviews: [imageView, titleLabel, subtitleLabel])
    stack.axis = .vertical
    stack.spacing = 12
    stack.alignment = .center
    stack.translatesAutoresizingMaskIntoConstraints = false
    
    emptyView.addSubview(stack)
    NSLayoutConstraint.activate([
        imageView.widthAnchor.constraint(equalToConstant: 70),
        imageView.heightAnchor.constraint(equalToConstant: 70),
        stack.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor),
        stack.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor)
    ])
    
    tableView.backgroundView = emptyView
}
}

// MARK: - TableView
extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return presenter.favoritesCount
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "LeagueCell", for: indexPath) as! LeagueCell
        
        let league = presenter.getFavorite(at: indexPath.row)
        cell.nameLabel.text = league.leagueName ?? "Unknown League"
        cell.countryLabel.text = ""
        
        cell.badgeImageView.image = UIImage(systemName: "photo")
        if let logoStr = league.leagueBadge, let url = URL(string: logoStr) {
            URLSession.shared.dataTask(with: url) { data, _, _ in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        cell.badgeImageView.image = image
                    }
                }
            }.resume()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat { 80 }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath, animated: true)

        if NetworkReachability.isConnected() {

            presenter.didSelectLeague(at: indexPath.row)

            let league = presenter.getFavorite(at: indexPath.row)

            if let sportName = league.sportName,
                 let sport = Sport(rawValue: sportName + "/") {
                  APIConfig.endpoint = sport
              }
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(
                withIdentifier: Constant.leaguesDetails
            ) as! LeagueDetailsViewController

            if let sportName = league.sportName,
                 let sport = Sport(rawValue: sportName + "/") {
                  vc.sport = sport
              }
            print("Navigating with sport: \(vc.sport)")
            var leagueObj = League()

            leagueObj.league_key = Int(league.leagueId)
            leagueObj.league_name = league.leagueName
            leagueObj.league_logo = league.leagueBadge

            vc.league = leagueObj
            vc.hidesBottomBarWhenPushed = true

            navigationController?.pushViewController(vc, animated: true)

        } else {

            showNoInternetAlert()
        }
    }
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alert = UIAlertController(
                title: "Remove Favorite",
                message: "Are you sure you want to remove this league from favorites?",
                preferredStyle: .alert
            )
            
            alert.addAction(UIAlertAction(title: "Remove", style: .destructive) { _ in
                self.presenter.deleteFavorite(at: indexPath.row)
            })
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel) { _ in
                tableView.reloadRows(at: [indexPath], with: .automatic)
            })
            
            present(alert, animated: true)
        }
    }

}

