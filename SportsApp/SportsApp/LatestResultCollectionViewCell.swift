//
//  LatestResultCollectionViewCell.swift
//  SportsApp
//
//  Created by Eyad waleed on 05/05/2026.
//

import UIKit

class LatestResultCollectionViewCell: UICollectionViewCell {

   
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
         super.layoutSubviews()
        self.layer.borderWidth = 2
         self.layer.borderColor = UIColor(hex: "45464D", alpha: 0.3).cgColor
         self.layer.cornerRadius = 8
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
}

