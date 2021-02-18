//
//  Setting.swift
//  YouTubeApp
//
//  Created by Артём Устинов on 17.02.2021.
//  Copyright © 2021 Artem Ustinov. All rights reserved.
//

import Foundation

class Setting: NSObject {
    
    var name: SettingName
    var imageName: String
    
    init(name: SettingName, imageName: String) {
        self.name = name
        self.imageName = imageName
    }
    
    enum SettingName: String {
        case settings = "Settings"
        case termsPrivacy = "Term & privacy policy"
        case sendFeedback = "Send feedback"
        case help = "Help"
        case switchAccount = "Switch account"
        case cancel = "Cancel"
    }
}
