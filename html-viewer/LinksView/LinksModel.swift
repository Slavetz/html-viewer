//
//  LinksModel.swift
//  html-viewer
//
//  Created by Zoic on 25/05/2019.
//  Copyright © 2019 v.lumelskiy. All rights reserved.
//

import Foundation

var LinksItemsObject: [[String: Any]] {
    set {
        UserDefaults.standard.set(newValue, forKey: "LinksItemsKey")
        UserDefaults.standard.synchronize()
    }
    get {
        if let array = UserDefaults.standard.array(forKey: "LinksItemsKey") as? [[String: Any]] {
            return array
        } else {
            return []
        }
    }
}

func addLinkItem(item: [String:Any]) {
    LinksItemsObject.append(item)
}

func editLinkItem(at index:Int, item: [String:Any]) {
    LinksItemsObject[index] = item
}

func removeLinkItem(at index:Int) {
    LinksItemsObject.remove(at: index)
}
