//
//  LeaguesViewController.swift
//  SportsApp
//
//  Created by Fatema Emara on 05/05/2026.
//

import UIKit

class LeaguesViewController: UITableViewController {

    let leagues = [
            ("Premier League", "England", "footballimg"),
            ("NBA",            "USA",     "basketballimg"),
            ("La Liga",        "Spain",   "footballimg"),
            ("NFL",            "USA",     "footballimg"),
            ("Champions League", "Europe", "footballimg")
        ]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Leagues"
               view.backgroundColor = UIColor(red: 0.05, green: 0.1, blue: 0.16, alpha: 1)
               tableView.backgroundColor = UIColor(red: 0.05, green: 0.1, blue: 0.16, alpha: 1)
               tableView.separatorStyle = .none
               tableView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
               
              
               tableView.register(LeagueCell.self, forCellReuseIdentifier: "LeagueCell")
               
              
               let appearance = UINavigationBarAppearance()
               appearance.configureWithOpaqueBackground()
               appearance.backgroundColor = UIColor(red: 0.05, green: 0.1, blue: 0.16, alpha: 1)
               appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
               navigationController?.navigationBar.standardAppearance = appearance
               navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        
     
        let starButton = UIBarButtonItem(image: UIImage(systemName: "star"),
                                         style: .plain,
                                         target: self,
                                         action: #selector(starTapped))
        starButton.tintColor = .white
        navigationItem.rightBarButtonItem = starButton
    
    }
    
    @objc func starTapped() {
            // Star action later
        }
        
        // MARK: - TableView
        override func tableView(_ tableView: UITableView,
                                numberOfRowsInSection section: Int) -> Int {
            return leagues.count
        }
    
    
    override func tableView(_ tableView: UITableView,
                                cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "LeagueCell",
                for: indexPath
            ) as! LeagueCell
            
            let league = leagues[indexPath.row]
            cell.configure(name: league.0, country: league.1, imageName: league.2)
            return cell
        }
    override func tableView(_ tableView: UITableView,
                               heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 80
       }
       
       override func tableView(_ tableView: UITableView,
                               didSelectRowAt indexPath: IndexPath) {
           tableView.deselectRow(at: indexPath, animated: true)
           // Navigate to LeagueDetails later
       }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
