//
//  Video.swift
//  YouTubeApp
//
//  Created by Артём Устинов on 14.02.2021.
//  Copyright © 2021 Artem Ustinov. All rights reserved.
//

import Foundation

struct Video {
    let title: String?
    let thumbnailImageName: String?
    let numberOfViews: NSNumber?
    let uploadDate: String?  // After change to Date!!!
    
    let channel: Channel?
}
