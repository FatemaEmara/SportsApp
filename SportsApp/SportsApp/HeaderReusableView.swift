//
//  HeaderReusableView.swift
//  SportsApp
//
//  Created by Eyad waleed on 05/05/2026.
//

import UIKit

class HeaderReusableView: UICollectionReusableView {
    @IBOutlet weak var headerName: UILabel!
    
    @IBOutlet weak var headerIcon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configure(headerName : String, icon :UIImage) {
        self.headerName.text = headerName
        self.headerIcon.image = icon
    }
    
}
