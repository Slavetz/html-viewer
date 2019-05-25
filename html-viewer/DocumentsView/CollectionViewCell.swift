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
    
    // стиль для картинки
    //cell.thumbnail.layer.borderColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0).cgColor
    //cell.thumbnail.layer.borderWidth = 1
    //cell.thumbnail.layer.cornerRadius = 5.0
    //cell.thumbnail.layer.masksToBounds = true
    
}
