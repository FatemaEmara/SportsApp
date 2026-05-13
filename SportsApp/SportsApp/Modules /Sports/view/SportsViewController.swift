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
        _ = NetworkReachability.shared

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

       
    }
    
  
    func showNoInternetAlert() {

        let alert = UIAlertController(
            title: "No Internet",
            message: "Please check your connection.",
            preferredStyle: .alert
        )

        alert.addAction(UIAlertAction(
            title: "OK",
            style: .default
        ))

        present(alert, animated: true)
    }


}

// MARK: - Delegate
extension SportsViewController: UICollectionViewDelegate {
   
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {

        selectedIndex = indexPath.item

        if NetworkReachability.isConnected() {

            let storyboard = UIStoryboard(name: "Main", bundle: nil)

            APIConfig.endpoint = Sport.allCases[selectedIndex]

            let vc = storyboard.instantiateViewController(
                withIdentifier: Constant.leaguesIdentifer
            ) as! LeaguesViewController

            vc.selectedSport = Sport.allCases[selectedIndex].rawValue

            navigationController?.pushViewController(vc, animated: true)

        } else {

            showNoInternetAlert()
        }
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
        let spacing: CGFloat = 16        
        let padding: CGFloat = 24
        let width = (collectionView.frame.width - padding * 2 - spacing) / 2
        return CGSize(width: width, height: width * 1.2)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 24, bottom: 16, right: 24)
    }
}
