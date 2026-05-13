//
//  OnBoardingFirstScreenViewController.swift
//  SportsApp
//
//  Created by Fatema Emara on 12/05/2026.
//

import UIKit

class FirstOnboardingViewController: UIViewController {

    @IBAction func nextBtn(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = storyboard.instantiateViewController(withIdentifier: "SecOnboardingVC")
        nextVC.modalPresentationStyle = .fullScreen
        present(nextVC, animated: true)
    }
    @IBAction func SkipBtn(_ sender: Any) {
        UserDefaults.standard.set(true, forKey: "hasSeenOnboarding")
          navigateToMainApp()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    func navigateToMainApp() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabBar = storyboard.instantiateViewController(withIdentifier: "MainTabBar")
        tabBar.modalPresentationStyle = .fullScreen
        present(tabBar, animated: true)
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
