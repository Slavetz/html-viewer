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
        
        cell.textLabel.text = item["title"] as? String
        cell.thumbnail.image = item["preview"] as? UIImage

        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = DocumentsItemsObject[indexPath.row]
        print(item["link"] ?? "nil")
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initDocumentsModel()
    }


}

