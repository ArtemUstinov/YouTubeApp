//
//  Video.swift
//  YouTubeApp
//
//  Created by Артём Устинов on 14.02.2021.
//  Copyright © 2021 Artem Ustinov. All rights reserved.
//

import Foundation

struct Video: Decodable {
    var title: String?
    var numberOfViews: Int?  //NSNumber
    var thumbnailImageName: String?
//    var uploadDate: String?  // After change to Date!!!
    var duration: Int?
    let numberOfLikes: Int?
    var channel: Channel?
    
    
    enum CodingKeys: String, CodingKey {
        case title
        case numberOfViews = "number_of_views"
        case thumbnailImageName = "thumbnail_image_name"
        case duration
        case numberOfLikes = "number_of_likes"
        case channel
    }
    
//    init(title: String? = nil, thumbnailImageName: String? = nil, numberOfViews: NSNumber? = nil, uploadDate: String? = nil, channel: Channel? = nil) {
//        self.title = title
//        self.thumbnailImageName = thumbnailImageName
//        self.numberOfViews = numberOfViews
//        self.uploadDate = uploadDate
//        self.channel = channel
//    }
}
