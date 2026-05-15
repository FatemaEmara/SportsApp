//
//  SecOnboardingViewController.swift
//  SportsApp
//
//  Created by Fatema Emara on 13/05/2026.
//

import UIKit

class SecOnboardingViewController: UIViewController {

    @IBAction func nextBtn(_ sender: Any) {

        navigateToMainApp()
       
    }
    func navigateToMainApp() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = storyboard.instantiateViewController(withIdentifier: "homeScreen")
        UserDefaults.standard.set(true, forKey: "hasSeenOnboarding")
        navigationController?.pushViewController(nextVC, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)

        // Do any additional setup after loading the view.
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
