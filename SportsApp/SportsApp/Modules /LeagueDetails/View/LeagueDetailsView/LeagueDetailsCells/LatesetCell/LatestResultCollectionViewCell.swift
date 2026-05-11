//
//  LatestResultCollectionViewCell.swift
//  SportsApp
//
//  Created by Eyad waleed on 05/05/2026.
//

import UIKit

class LatestResultCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var teamTwoLabel: UILabel!
    
    @IBOutlet weak var teamOneLabel: UILabel!
    @IBOutlet weak var matchDate: UILabel!
    @IBOutlet weak var homeTeamLogo: UIImageView!
    
    @IBOutlet weak var awayTeamResult: UILabel!
    @IBOutlet weak var teamHomeResult: UILabel!
    @IBOutlet weak var awayHomeLogo: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
         super.layoutSubviews()
        self.layer.borderWidth = 2
         self.layer.borderColor = UIColor(hex: "45464D", alpha: 0.3).cgColor
         self.layer.cornerRadius = 8
     }
    func configure(with event: Event) {
        teamOneLabel.text = event.homeTeamName
        teamTwoLabel.text = event.awayTeamName
        homeTeamLogo.sd_setImage(with: URL(string: event.homeTeamLogo ?? ""))
        awayHomeLogo.sd_setImage(with: URL(string: event.awayTeamLogo ?? ""))
        applyScoreColors(result: event.eventFinalResult)
    }
    private func applyScoreColors(result: String?) {
        guard let scores = result?.components(separatedBy: " - "),
              scores.count == 2,
              let home = Int(scores[0]),
              let away = Int(scores[1]) else { return }

        teamHomeResult.text = scores[0]
        awayTeamResult.text = scores[1]
        
        if home > away {
            teamHomeResult.textColor = .winGreen
            awayTeamResult.textColor = .lossRed
        } else if away > home {
            teamHomeResult.textColor = .lossRed
            awayTeamResult.textColor = .winGreen
        } else {
            teamHomeResult.textColor = .white
            awayTeamResult.textColor = .white
        }
    }

}

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        let hex = hex.trimmingCharacters(in: .alphanumerics.inverted)
        var rgb: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&rgb)
        self.init(
            red: CGFloat((rgb >> 16) & 0xFF) / 255,
            green: CGFloat((rgb >> 8) & 0xFF) / 255,
            blue: CGFloat(rgb & 0xFF) / 255,
            alpha: alpha
        )
    }
    static let winGreen  = UIColor(red: 74/255, green: 225/255, blue: 118/255, alpha: 1.0)
     static let lossRed   = UIColor.red
}

