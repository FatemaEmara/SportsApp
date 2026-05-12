//
//  FavoritesViewController.swift
//  SportsApp
//
//  Created by Fatema Emara on 06/05/2026.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var presenter: FavoritesPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = FavoritesPresenter(view: self)
        setupBackground()
        setupNavigationBar()
        setupTableView()
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
    }
    
    func showNoInternetAlert() {
        let alert = UIAlertController(
            title: "No Internet",
            message: "Please check your connection.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
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
        presenter.didSelectLeague(at: indexPath.row)
        
        if NetworkReachability.isConnected() {
            let league = presenter.getFavorite(at: indexPath.row)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(
                withIdentifier: Constant.leaguesDetails
            ) as! LeagueDetailsViewController
            var leagueObj = League()
            leagueObj.league_key = Int(league.leagueId)
            leagueObj.league_name = league.leagueName
            leagueObj.league_logo = league.leagueBadge
            vc.league = leagueObj
            navigationController?.pushViewController(vc, animated: true)
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
