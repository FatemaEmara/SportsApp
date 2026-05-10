//
//  FavoritesViewController.swift
//  SportsApp
//
//  Created by Fatema Emara on 06/05/2026.
//


import UIKit

class FavoritesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let mockLeagues = [
        ("Premier League", "England", "footballimg"),
        ("NBA",            "USA",     "basketballimg"),
        ("La Liga",        "Spain",   "footballimg"),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        setupNavigationBar()
        setupTableView()
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
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setupTableView() {
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
    }
}

// MARK: - TableView DataSource
extension FavoritesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return mockLeagues.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "LeagueCell",
            for: indexPath
        ) as! LeagueCell
        
        let league = mockLeagues[indexPath.row]
        cell.nameLabel.text = league.0
        cell.countryLabel.text = league.1
        cell.badgeImageView.image = UIImage(named: league.2)
        return cell
    }
}

// MARK: - TableView Delegate
extension FavoritesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // Logic later
    }
}
