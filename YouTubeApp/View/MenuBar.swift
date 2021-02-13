//
//  MenuBar.swift
//  YouTubeApp
//
//  Created by Артём Устинов on 18.01.2021.
//  Copyright © 2021 Artem Ustinov. All rights reserved.
//

import UIKit

class MenuBar: UIView {
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.getRgb(red: 230,
                                         green: 32,
                                         blue: 31)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
