//
//  Media.swift
//  1lensTest
//
//  Created by Galym Anuarbek on 2/11/20.
//  Copyright © 2020 Galym Anuarbek. All rights reserved.
//

import UIKit

struct Media {
    
    var mediaJSON = getMedia()
    
    static let baseImgUrl = "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/"
    
    static func getMedia() -> [Video] {
        if let path = Bundle.main.path(forResource: "media", ofType: "json") {
            do {
                var videosList: [Video] = []
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? Dictionary<String, AnyObject>, let categories = jsonResult["categories"] as? [[String:Any]], let videos = categories[0]["videos"] as? [[String:Any]] {
                    for video in videos {
                        let descr = video["description"] as? String
                        let sources = video["sources"] as? [String]
                        let subtitle = video["subtitle"] as? String
                        let thumb = video["thumb"] as? String
                        let title = video["title"] as? String
                        let thisVideo = Video(descr: descr, sources: sources ?? [], subtitle: subtitle, thumb: thumb, title: title)
                        videosList.append(thisVideo)
                    }
                }
                return videosList
              } catch {
                return []
              }
        }
        return []
    }
}
