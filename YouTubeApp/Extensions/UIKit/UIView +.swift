//
//  UIView +.swift
//  YouTubeApp
//
//  Created by Артём Устинов on 13.01.2021.
//  Copyright © 2021 Artem Ustinov. All rights reserved.
//

import UIKit

extension UIView {
    
    func addConstraintsWithFormat(format: String, views: [UIView]) {
        
        var viewDectionary = [String : UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewDectionary[key] = view
        }
        
        NSLayoutConstraint.activate(
            NSLayoutConstraint.constraints(
                withVisualFormat: format,
                metrics: nil,
                views: viewDectionary)
        )
    }
}
