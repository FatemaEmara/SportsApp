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

        navigationController?.navigationBar.shadowImage =   UIImage()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
    }



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
        print(APIConfig.endpoint.rawValue)
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


extension SportsViewController : UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding : CGFloat = 35
        let width = (collectionView.bounds.width - (padding * 3 ))/2
        return CGSize(width: width, height: width * 1.1 )
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 40
    }

    func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 50, left: 25, bottom: 5, right: 40)
    }

}
