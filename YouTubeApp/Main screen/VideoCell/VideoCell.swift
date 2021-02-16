//
//  VideoCell.swift
//  YouTubeApp
//
//  Created by Артём Устинов on 13.01.2021.
//  Copyright © 2021 Artem Ustinov. All rights reserved.
//

import UIKit

class VideoCell: BaseCell {
    
    //MARK: - UI elements:
    let thumbnailImageView: CustomImageView = {
        let imageView = CustomImageView()
        //        imageView.backgroundColor = .blue
//        imageView.image = UIImage(named: "jackson")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let userProfileImageView: CustomImageView = {
        let imageView = CustomImageView()
        //        imageView.backgroundColor = .green
//        imageView.image = UIImage(named: "jacksonMini")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 22
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        //        label.backgroundColor = .purple
        label.text = "Taylor Swift - Blank Space"
        label.numberOfLines = 0
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
    
    //MARK: - Properties:
    var video: Video? {
        didSet {
            titleLabel.text = video?.title

            thumbnailImageView.loadImage(from: video?.thumbnailImageName ?? "")
            userProfileImageView.loadImage(from: video?.channel?.profileImageName ?? "")
            
            if let chanelName = video?.channel?.name,
               let numberOfViews = video?.numberOfViews {
                
                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = .decimal
                let number = numberFormatter.string(from: numberOfViews)
                let text =
                    "\(chanelName) • \(number ?? "") • \(video?.uploadDate ?? "")"
                subtitleTextView.text = text
            }
            
            if let title = video?.title {
                let size = CGSize(width: frame.width - 16 - 44 - 8 - 16,
                                  height: frame.height)
                let options =
                    NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
                let attributes =
                    [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
                let estimatedRect =
                    title.boundingRect(with: size,
                                       options: options,
                                       attributes: attributes,
                                       context: nil)
                if estimatedRect.size.height > 20 {
                    titleLabelConstraint?.constant = 44
                } else {
                    titleLabelConstraint?.constant = 20
                }
            }
        }
    }
    
    private var titleLabelConstraint: NSLayoutConstraint?
    
    override func prepareForReuse() {
        thumbnailImageView.image = nil
        userProfileImageView.image = nil
        titleLabel.text = nil
        subtitleTextView.text = nil
    }
    
    //MARK: - SetupViews:
    override func setupViews() {
        addSubview(thumbnailImageView)
        addSubview(userProfileImageView)
        addSubview(titleLabel)
        addSubview(subtitleTextView)
        addSubview(separatorView)
    }
    
    override func setupLayouts() {
        
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
        addConstraintsWithFormat(format: "V:|-16-[v0]-8-[v1(44)]-36-[v2(1)]|",
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
//        titleLabelConstraint = NSLayoutConstraint(item: titleLabel,
//                                                  attribute: .height,
//                                                  relatedBy: .equal,
//                                                  toItem: self,
//                                                  attribute: .height,
//                                                  multiplier: 0,
//                                                  constant: 20)
//        addConstraint(titleLabelConstraint!)
        addConstraintsWithFormat(format: "V:[v0(30)]",
                                 views: [subtitleTextView])
    }
}


