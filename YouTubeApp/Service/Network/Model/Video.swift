//
//  Video.swift
//  YouTubeApp
//
//  Created by Артём Устинов on 14.02.2021.
//  Copyright © 2021 Artem Ustinov. All rights reserved.
//

struct Video: Decodable {
    var title: String?
    var numberOfViews: Int?
    var thumbnailImageName: String?
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
}
