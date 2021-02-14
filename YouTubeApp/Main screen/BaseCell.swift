//
//  BaseCell.swift
//  YouTubeApp
//
//  Created by Артём Устинов on 14.02.2021.
//  Copyright © 2021 Artem Ustinov. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    
    //MARK: - Initializers:
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupLayouts()
    }
    
    func setupViews() {}
    func setupLayouts() {}
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
