//
//  DocumentsModel.swift
//  html-viewer
//
//  Created by Zoic on 25/05/2019.
//  Copyright © 2019 v.lumelskiy. All rights reserved.
//

import Foundation

var DocumentsItemsObject:[[String:String]] = [
    ["title":"Folder-1","preview":"Folder-1/preview.jpg"],
    ["title":"Folder-2","preview":"Folder-2/preview.jpg"],
    ["title":"Folder-3","preview":"Folder-3/preview.jpg"],
    ["title":"Folder-4","preview":"Folder-4/preview.jpg"]
]

func initDocumentsModel(){
    
    #if targetEnvironment(simulator)
    print("It's an iOS Simulator")
    print("Try to copy demo content")
    copyFolders()
    #else
    print("It's a device")
    #endif
    
    DocumentsItemsObject = getFolders().map({ (folder: String) ->[String:String] in
        return ["title": folder, "preview": folder+"/preview.jpg"]
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
