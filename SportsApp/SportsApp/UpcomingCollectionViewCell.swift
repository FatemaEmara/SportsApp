//
//  CollectionViewCell.swift
//  SportsApp
//
//  Created by Eyad waleed on 05/05/2026.
//

import UIKit

class UpcomingCollectionViewCell: UICollectionViewCell {

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
 
}

