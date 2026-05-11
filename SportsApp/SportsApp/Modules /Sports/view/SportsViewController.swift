//
//  SportsViewController.swift
//  SportsApp
//
//  Created by Fatema Emara on 05/05/2026.
//

import UIKit

class SportsViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!

    let sports = [
        ("Football",   "footballimg"),
        ("Basketball", "basketballimg"),
        ("Tennis",     "tennisimg"),
        ("Cricket",    "cricketimg")
    ]

    let sportAPINames: [String: String] = [
        "Football":   "football",
        "Basketball": "basketball",
        "Tennis":     "tennis",
        "Cricket":    "cricket"
    ]

    var selectedIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.05, green: 0.1, blue: 0.16, alpha: 1)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        setupNavigationBar()
    }

    func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(red: 0.05, green: 0.1, blue: 0.16, alpha: 1)
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance

        let logoImageView = UIImageView()
        logoImageView.image = UIImage(named: "userprofile")
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.clipsToBounds = true
        logoImageView.layer.cornerRadius = 15
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        logoImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true

        let titleLabel = UILabel()
        titleLabel.text = "Sports"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)

        let leftStack = UIStackView(arrangedSubviews: [logoImageView, titleLabel])
        leftStack.axis = .horizontal
        leftStack.spacing = 8
        leftStack.alignment = .center

        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftStack)

        let starButton = UIBarButtonItem(
            image: UIImage(systemName: "star"),
            style: .plain,
            target: self,
            action: #selector(starTapped)
        )
        starButton.tintColor = .white
        navigationItem.rightBarButtonItem = starButton
    }

    @objc func starTapped() { }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showLeagues" {
            let vc = segue.destination as! LeaguesViewController
            let sportDisplayName = sports[selectedIndex].0
            vc.selectedSport = sportAPINames[sportDisplayName] ?? "football"
        }
    }
}

// MARK: - Delegate
extension SportsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.item   
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        APIConfig.endpoint = Sport.allCases[selectedIndex]
        let vc = storyboard.instantiateViewController(withIdentifier: Constant.leaguesIdentifer) as!  LeaguesViewController
        vc.selectedSport = Sport.allCases[selectedIndex].rawValue
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - DataSource
extension SportsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return sports.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "SportCell", for: indexPath) as! SportCell
        let sport = sports[indexPath.item]
        cell.configure(name: sport.0, imageName: sport.1)
        return cell
    }
}

// MARK: - Layout
extension SportsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalPadding: CGFloat = 16 + 16 + 12
        let width = (collectionView.frame.width - totalPadding) / 2
        return CGSize(width: width, height: width * 1.1)
    }
}
