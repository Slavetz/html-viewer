//
//  CollectionViewCell.swift
//  html-viewer
//
//  Created by Zoic on 25/05/2019.
//  Copyright © 2019 v.lumelskiy. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        // стиль для картинки
        thumbnail.layer.borderColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0).cgColor
        thumbnail.layer.borderWidth = 1
        thumbnail.layer.cornerRadius = 5.0
        thumbnail.layer.masksToBounds = true
    }
    
    
    
}
