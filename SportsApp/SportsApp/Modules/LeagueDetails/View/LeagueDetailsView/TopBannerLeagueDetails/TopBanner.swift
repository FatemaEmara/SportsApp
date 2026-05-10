//
//  TopBanner.swift
//  SportsApp
//
//  Created by Eyad waleed on 05/05/2026.
//

import UIKit

class TopBanner: UICollectionReusableView {
    @IBOutlet weak var leagueName: UILabel!
    
    @IBOutlet weak var leagueLogo: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configure( leagueName: String , leagueLogo : String) {
        self.leagueName.text = leagueName
        self.leagueLogo.sd_setImage(
            with: URL(string: leagueLogo ?? ""),
            placeholderImage: UIImage(named: "stadium")
        )
    }
    
}
