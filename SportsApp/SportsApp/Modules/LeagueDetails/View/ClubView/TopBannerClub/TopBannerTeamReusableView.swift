//
//  TopBannerTeamReusableView.swift
//  SportsApp
//
//  Created by Eyad waleed on 06/05/2026.
//

import UIKit

class TopBannerTeamReusableView: UICollectionReusableView {
    @IBOutlet weak var clubImagw: UIImageView!
    @IBOutlet weak var clubName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with team: Team) {
        clubName.text = team.teamName
        clubImagw.sd_setImage(
            with: URL(string: team.teamLogo ?? ""),
            placeholderImage: UIImage(named: "stadium")
        )
    }
    
    
}
