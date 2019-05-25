//
//  FirstViewController.swift
//  html-viewer
//
//  Created by Zoic on 25/05/2019.
//  Copyright © 2019 v.lumelskiy. All rights reserved.
//

import UIKit

class DocumentsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DocumentsItemsObject.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = DocumentsItemsObject[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DocumentCell", for: indexPath) as! CollectionViewCell
        cell.textLabel.text = item["title"]
        
        let url = getDocumentsURL().appendingPathComponent(item["preview"]!)
        let data = try? Data(contentsOf: url) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
        if (data != nil) {
            cell.thumbnail.image = UIImage(data: data!)
        }
        
        // стиль для картинки
        cell.thumbnail.layer.borderColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0).cgColor
        cell.thumbnail.layer.borderWidth = 1
        cell.thumbnail.layer.cornerRadius = 5.0
        cell.thumbnail.layer.masksToBounds = true

        return cell
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initDocumentsModel()
    }


}

