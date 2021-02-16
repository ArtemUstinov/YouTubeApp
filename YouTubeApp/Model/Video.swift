//
//  Video.swift
//  YouTubeApp
//
//  Created by Артём Устинов on 14.02.2021.
//  Copyright © 2021 Artem Ustinov. All rights reserved.
//

import Foundation

struct Video {
    var title: String?
    var thumbnailImageName: String?
    let numberOfViews: NSNumber?
    let uploadDate: String?  // After change to Date!!!
    
    var channel: Channel?
    
    init(title: String? = nil, thumbnailImageName: String? = nil, numberOfViews: NSNumber? = nil, uploadDate: String? = nil, channel: Channel? = nil) {
        self.title = title
        self.thumbnailImageName = thumbnailImageName
        self.numberOfViews = numberOfViews
        self.uploadDate = uploadDate
        self.channel = channel
    }
}
