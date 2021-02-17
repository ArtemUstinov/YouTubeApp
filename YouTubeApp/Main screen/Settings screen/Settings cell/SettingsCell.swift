//
//  SettingsCell.swift
//  YouTubeApp
//
//  Created by Артём Устинов on 17.02.2021.
//  Copyright © 2021 Artem Ustinov. All rights reserved.
//

import UIKit

class SettingsCell: BaseCell {
    
    //MARK: - UI elements:
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Settings"
        label.font = .systemFont(ofSize: 13)
        return label
    }()
    private let iconImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "settings")
        image.contentMode = .scaleAspectFill
        image.tintColor = .darkGray
        return image
    }()
    
    //MARK: - DidSet properties:
    var setting: Setting? {
        didSet {
            nameLabel.text = setting?.name
            iconImageView.image =
                UIImage(named: setting?.imageName ?? "")?.withRenderingMode(.alwaysTemplate)
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? .darkGray : .white
            nameLabel.textColor = isHighlighted ? .white : .black
            iconImageView.tintColor = isHighlighted ? .white : .darkGray
        }
    }
    
    //MARK: - Setup Views:
    override func setupViews() {
        super.setupViews()
        
        addSubview(nameLabel)
        addSubview(iconImageView)
        
        addConstraintsWithFormat(format: "H:|-8-[v0(30)]-8-[v1]|",
                                 views: [iconImageView,nameLabel])
        addConstraintsWithFormat(format: "V:|[v0]|",
                                 views: [nameLabel])
        addConstraintsWithFormat(format: "V:[v0(30)]",
                                 views: [iconImageView])
        
        NSLayoutConstraint.activate([
            iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor,
                                                   constant: 0)
        ])
    }
}
