//
//  DocumentsModel.swift
//  html-viewer
//
//  Created by Zoic on 25/05/2019.
//  Copyright © 2019 v.lumelskiy. All rights reserved.
//

import Foundation
import UIKit

var DocumentsItemsObject:[[String:Any]] = []

func initDocumentsModel(){
    
    #if targetEnvironment(simulator)
    print("It's an iOS Simulator")
    print("Try to copy demo content")
    copyFolders()
    #else
    print("It's a device")
    #endif
    
    DocumentsItemsObject = getFolders().map({ (folder: String) -> [String:Any] in
        
        var item:[String:Any] = ["title": folder]
        
        let imageUrl = getDocumentsURL().appendingPathComponent(folder+"/preview.jpg")
        let imageData = try? Data(contentsOf: imageUrl)
        if (imageData != nil) {
            item["preview"] = UIImage(data: imageData!)
        } else {
            item["preview"] = UIImage()
        }
        
        let htmlUrl = getDocumentsURL().appendingPathComponent(folder+"/index.html")
        let htmlData = try? Data(contentsOf: htmlUrl)
        if (htmlData != nil) {
            item["link"] = htmlUrl
        } else {
            item["link"] = nil
        }
        
        //todo: попытаться прочитать project.json если ок > поменять title
        
        return item
    })
    
}

func getDocumentsURL() -> URL {
    let fileManager = FileManager.default
    return fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
}

func getFolders() -> [String] {
    let fileManager = FileManager.default
    let docsURL = getDocumentsURL()
    
    do {
        
        let fileURLs = try fileManager.contentsOfDirectory(at: docsURL, includingPropertiesForKeys: nil)
        var urlsData = fileURLs.map { $0.lastPathComponent }
        urlsData = urlsData.filter { $0 != "index.html" }
        return urlsData
        
    } catch {
        
        print("Error while enumerating files \(docsURL): \(error.localizedDescription)")
        return []
        
    }
    
}


// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// Переписывае файлы в документы

func copyFolders() {
    let docsURL = getDocumentsURL()
    if let folderPath = ProcessInfo.processInfo.environment["SRCROOT"] {
        copyFiles(pathFromBundle: folderPath + "/Documents", pathDestDocs: docsURL.path)
    } else {
        print("cant get folderPath")
    }
    
    
}

func copyFiles(pathFromBundle: String, pathDestDocs: String) {
    let fileManager = FileManager.default
    do {
        let filelist = try fileManager.contentsOfDirectory(atPath: pathFromBundle)
        try? fileManager.copyItem(atPath: pathFromBundle, toPath: pathDestDocs)
        
        for filename in filelist {
            try? fileManager.copyItem(atPath: "\(pathFromBundle)/\(filename)", toPath: "\(pathDestDocs)/\(filename)")
        }
    } catch {
        print("\nError\n")
    }
}
