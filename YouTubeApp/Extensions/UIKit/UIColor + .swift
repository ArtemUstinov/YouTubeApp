//
//  UIColor + .swift
//  YouTubeApp
//
//  Created by Артём Устинов on 18.01.2021.
//  Copyright © 2021 Artem Ustinov. All rights reserved.
//

import UIKit

extension UIColor {
    
    static func getRgb(red: CGFloat,
                       green: CGFloat,
                       blue: CGFloat) -> UIColor {
        
        UIColor(red: red/255,
                green: green/255,
                blue: blue/255, alpha: 1)
    }
}
