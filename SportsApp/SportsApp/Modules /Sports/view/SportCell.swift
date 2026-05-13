//
//  SportCellCollectionViewCell.swift
//  SportsApp
//
//  Created by Fatema Emara on 05/05/2026.
//

import UIKit

class SportCell: UICollectionViewCell {
    @IBOutlet weak var sportImageView: UIImageView!
    @IBOutlet weak var sportNameLabel: UILabel!

      func configure(name: String, imageName: String) {
          sportNameLabel.text = name
          sportImageView.image = UIImage(named: imageName)
      }
}
