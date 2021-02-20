//
//  MenuCell.swift
//  YouTubeApp
//
//  Created by Артём Устинов on 14.02.2021.
//  Copyright © 2021 Artem Ustinov. All rights reserved.
//

import UIKit

class MenuCell: BaseCell {
    
    //MARK: - UI elements:
    let imageView: UIImageView = {
        let image = UIImageView()
        image.tintColor = UIColor.getRgb(red: 91,
                                         green: 14,
                                         blue: 13)
        return image
    }()
    
    //MARK: - Override methods:
    override var isSelected: Bool {
        didSet {
            imageView.tintColor =
                isSelected ? .white : UIColor.getRgb(red: 91,
                                                     green: 14,
                                                     blue: 13)
        }
    }
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(imageView)
        imageView.addConstraintsWithFormat(format: "V:[v0(28)]",
                                           views: [imageView])
        imageView.addConstraintsWithFormat(format: "H:[v0(28)]",
                                           views: [imageView])
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor,
                                               constant: 0),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor,
                                               constant: 0)
        ])
    }
}
