//
//  Channel.swift
//  YouTubeApp
//
//  Created by Артём Устинов on 14.02.2021.
//  Copyright © 2021 Artem Ustinov. All rights reserved.
//

struct Channel {
    var name: String?
    var profileImageName: String?
    
    init(name: String? = nil, profileImageName: String? = nil) {
        self.name = name
        self.profileImageName = profileImageName
    }
}
