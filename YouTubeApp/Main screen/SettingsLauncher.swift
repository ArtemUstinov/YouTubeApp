//
//  SettingsLauncher.swift
//  YouTubeApp
//
//  Created by Артём Устинов on 17.02.2021.
//  Copyright © 2021 Artem Ustinov. All rights reserved.
//

import UIKit

class SettingsLauncher {
    
    
    private let blackView = UIView()
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero,
                                  collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv
    }()
    
    func showSettings() {
        if let window =
            UIApplication.shared.windows.filter({$0.isKeyWindow}).first {
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            
            let tapGesture =
                UITapGestureRecognizer(target: self,
                                       action: #selector(dismissBlackView))
            blackView.addGestureRecognizer(tapGesture)
            
            window.addSubview(blackView)
            blackView.frame = window.frame
            blackView.alpha = 0
            
            window.addSubview(collectionView)
            let height: CGFloat = 200
            let y = window.frame.height - height
            collectionView.frame = CGRect(x: 0,
                                          y: window.frame.height,
                                          width: window.frame.width,
                                          height: height)
            
            UIView.animate(
                withDuration: 0.5,
                delay: 0,
                usingSpringWithDamping: 1,
                initialSpringVelocity: 1,
                options: .curveEaseOut,
                animations: {
                    self.blackView.alpha = 1
                    self.collectionView.frame =
                        CGRect(x: 0,
                               y: y,
                               width: self.collectionView.frame.width,
                               height: self.collectionView.frame.height)
                }, completion: nil
            )
        }
    }
    
    @objc private func dismissBlackView() {
        UIView.animate(withDuration: 0.5) {
            self.blackView.alpha = 0
            if let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first {
                self.collectionView.frame =
                    CGRect(x: 0,
                           y: window.frame.height,
                           width: self.collectionView.frame.width,
                           height: self.collectionView.frame.height)
            }
        }
    }
}
