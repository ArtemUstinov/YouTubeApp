//
//  Channel.swift
//  YouTubeApp
//
//  Created by Артём Устинов on 14.02.2021.
//  Copyright © 2021 Artem Ustinov. All rights reserved.
//

struct Channel: Decodable {
    var name: String?
    var profileImageName: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case profileImageName = "profile_image_name"
    }
    
//    init(name: String? = nil, profileImageName: String? = nil) {
//        self.name = name
//        self.profileImageName = profileImageName
//    }
}
