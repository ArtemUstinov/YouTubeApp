//
//  Setting.swift
//  YouTubeApp
//
//  Created by Артём Устинов on 17.02.2021.
//  Copyright © 2021 Artem Ustinov. All rights reserved.
//

import Foundation

class Setting: NSObject {
    
    var name: String
    var imageName: String
    
    init(name: String, imageName: String) {
        self.name = name
        self.imageName = imageName
    }
}
