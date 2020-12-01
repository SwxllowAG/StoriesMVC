//
//  Video.swift
//  1lensTest
//
//  Created by Galym Anuarbek on 2/11/20.
//  Copyright © 2020 Galym Anuarbek. All rights reserved.
//

import Foundation

class Video {
    var descr: String?
    var sources: [String]
    var subtitle: String?
    var thumb: String?
    var title: String?
    
    init(descr: String? = "", sources: [String] = [], subtitle: String? = "", thumb: String? = "", title: String? = "") {
        self.descr = descr
        self.sources = sources
        self.subtitle = subtitle
        self.thumb = thumb
        self.title = title
    }
}
