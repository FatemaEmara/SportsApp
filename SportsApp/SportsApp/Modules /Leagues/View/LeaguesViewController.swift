//
//  LeaguesViewController.swift
//  SportsApp
//
//  Created by Fatema Emara on 05/05/2026.
//

import UIKit
protocol LeaguesViewProtocol: AnyObject {
    func startAnimating()
    func stopAnimating()
    func reloadTable()
    func showError(_ message: String)
}

class LeaguesViewController: UITableViewController {

    var presenter: LeaguesPresenterProtocol?
    var selectedSport: String!
    let indicator = UIActivityIndicatorView(style: .large)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupPresenter()
    }

    private func setupUI() {
        title = "Leagues"
//        view.backgroundColor = UIColor(red: 0.05, green: 0.1, blue: 0.16, alpha: 1)
//        tableView.backgroundColor = UIColor(red: 0.05, green: 0.1, blue: 0.16, alpha: 1)
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
        tableView.register(LeagueCell.self, forCellReuseIdentifier: "LeagueCell")

        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .clear
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance

//        let starButton = UIBarButtonItem(image: UIImage(systemName: "star"),
//                                        style: .plain,
//                                        target: self,
//                                        action: #selector(starTapped))
//        starButton.tintColor = .white
//        navigationItem.rightBarButtonItem = starButton

       
        indicator.color = .white
    }

    private func setupPresenter() {
        presenter = LeaguesPresenter()
        presenter?.attachView(self)
        presenter?.fetchLeagues(for: selectedSport)
    }

    @objc func starTapped() {
    }
}

extension LeaguesViewController: LeaguesViewProtocol {

    func startAnimating() {
        indicator.center = view.center
        view.addSubview(indicator)
        indicator.startAnimating()
    }

    func stopAnimating() {
        indicator.stopAnimating()
        indicator.removeFromSuperview()
    }

    func reloadTable() {
        tableView.reloadData()
    }

    func showError(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

extension LeaguesViewController {

    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        presenter?.getItemsCount() ?? 0
    }

    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "LeagueCell", for: indexPath) as! LeagueCell
        if let league = presenter?.getLeague(at: indexPath.row) {
            cell.configure(with: league)
        }
        return cell
    }

    override func tableView(_ tableView: UITableView,
                            heightForRowAt indexPath: IndexPath) -> CGFloat { 80 }

    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: Constant.leaguesDetails) as! LeagueDetailsViewController
        vc.league = presenter!.getLeague(at: indexPath.row)
        navigationController?.pushViewController(vc, animated: true)
        
    }


   


}
