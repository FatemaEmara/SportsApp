//
//  ErrorCell.swift
//  SportsApp
//
//  Created by Eyad waleed on 11/05/2026.
//

import UIKit

class ErrorCell: UICollectionViewCell {

    @IBOutlet weak var errorMessage: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func config(message : String ) {
        errorMessage.text = message
    }

}
