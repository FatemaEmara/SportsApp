//
//  CollectionViewCell.swift
//  SportsApp
//
//  Created by Eyad waleed on 05/05/2026.
//

import UIKit

class UpcomingCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var teamOneLogo: UIImageView!
    
    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var teamLogoTwo: UIImageView!
    
    @IBOutlet weak var teamOneLabel: UILabel!
    @IBOutlet weak var teamLabelTwo: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
         super.layoutSubviews()
        self.layer.borderWidth = 2
         self.layer.borderColor = UIColor(hex: "45464D", alpha: 0.3).cgColor
         self.layer.cornerRadius = 8
     }
    func configure(with event: Event) {
        date.text = event.eventDate
        teamOneLabel.text = event.homeTeamName
        teamLabelTwo.text = event.awayTeamName
        teamOneLogo.sd_setImage(
            with: URL(string: event.homeTeamLogo ?? ""),
            placeholderImage: UIImage(named: "stadium")
        )
        teamLogoTwo.sd_setImage(
            with: URL(string: event.awayTeamLogo ?? ""),
            placeholderImage: UIImage(named: "stadium")
        )
    }
 
}

