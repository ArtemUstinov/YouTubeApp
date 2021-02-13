//
//  VideoCell.swift
//  YouTubeApp
//
//  Created by Артём Устинов on 13.01.2021.
//  Copyright © 2021 Artem Ustinov. All rights reserved.
//

import UIKit

class VideoCell: UICollectionViewCell {
    
    //MARK: - UI elements:
    let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .blue
        imageView.image = UIImage(named: "jackson")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let userProfileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .green
        imageView.image = UIImage(named: "jacksonMini")
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 22
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        //        label.backgroundColor = .purple
        label.text = "Taylor Swift - Blank Space"
        return label
    }()
    
    let subtitleTextView: UITextView = {
        let textView = UITextView()
        //        textView.backgroundColor = .red
        textView.text = "TaylorSwiftVEVO • 1,604,684,607 views • 2 years ago"
        textView.textContainerInset = UIEdgeInsets(top: 0, left: -4,
                                                   bottom: 0, right: 0)
        textView.textColor = .lightGray
        return textView
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 230/255,
                                       green: 230/255,
                                       blue: 230/255,
                                       alpha: 1)
        return view
    }()
    
    //MARK: - Initializers:
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - SetupViews:
    private func setupViews() {
        addSubview(thumbnailImageView)
        addSubview(userProfileImageView)
        addSubview(titleLabel)
        addSubview(subtitleTextView)
        addSubview(separatorView)
    }
    
    private func setupLayouts() {
        
        // H: thumbnailImageView line
        addConstraintsWithFormat(format: "H:|-16-[v0]-16-|",
                                 views: [thumbnailImageView])
        // H: titleLabel line
        addConstraintsWithFormat(format: "H:|-16-[v0(44)]-8-[v1]-16-|",
                                 views: [userProfileImageView, titleLabel])
        
        // H: subtitleTextView line
        addConstraintsWithFormat(format: "H:|-16-[v0(44)]-8-[v1]-16-|",
                                 views: [userProfileImageView, subtitleTextView])
        
        // H: separatorView line
        addConstraintsWithFormat(format: "H:|[v0]|",
                                 views: [separatorView])
        
        // V: thumbnailImageView line
        addConstraintsWithFormat(format: "V:|-16-[v0]-8-[v1(44)]-16-[v2(1)]|",
                                 views: [thumbnailImageView,
                                         userProfileImageView,
                                         separatorView])
        
        // titleLabel, subtitleTextView convienence constraints:
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor,
                                            constant: 8),
            subtitleTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,
                                                  constant: 4)
        ])
        addConstraintsWithFormat(format: "V:[v0(20)]",
                                 views: [titleLabel])
        addConstraintsWithFormat(format: "V:[v0(30)]",
                                 views: [subtitleTextView])
    }
    
    
}


