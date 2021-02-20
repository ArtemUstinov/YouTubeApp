//
//  SettingsLauncher.swift
//  YouTubeApp
//
//  Created by Артём Устинов on 17.02.2021.
//  Copyright © 2021 Artem Ustinov. All rights reserved.
//

import UIKit

class SettingsLauncher: NSObject {
    
    //MARK: - UI elements::
    private let blackView = UIView()
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero,
                                  collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv
    }()
    
    //MARK: - Properties:
    private let cellId = "Setting cell"
    private let cellHeight: CGFloat = 50
    
    private let settings = [
        Setting(name: .settings, imageName: "settings"),
        Setting(name: .termsPrivacy, imageName: "privacy"),
        Setting(name: .sendFeedback, imageName: "feedback"),
        Setting(name: .help, imageName: "help"),
        Setting(name: .switchAccount, imageName: "switch_account"),
        Setting(name: .cancel, imageName: "cancel")
    ]
    
    var homeController: HomeController?
    
    //MARK: - Initializers:
    override init() {
        super.init()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(SettingsCell.self,
                                forCellWithReuseIdentifier: cellId)
    }
    
    //MARK: - Public methods:
    func showSettings() {
        if let window =
            UIApplication.shared.windows.filter({$0.isKeyWindow}).first {
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            
            let tapGesture =
                UITapGestureRecognizer(target: self,
                                       action: #selector(handleDismiss))
            blackView.addGestureRecognizer(tapGesture)
            
            window.addSubview(blackView)
            blackView.frame = window.frame
            blackView.alpha = 0
            
            window.addSubview(collectionView)
            let height: CGFloat = CGFloat(settings.count) * cellHeight
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
    
    //MARK: - @objs methods:
    @objc private func handleDismiss(setting: Setting) {
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: 1,
                       options: .curveEaseOut) {
            
            self.blackView.alpha = 0
            
            if let window =
                UIApplication.shared.windows.filter({$0.isKeyWindow}).first {
                self.collectionView.frame =
                    CGRect(x: 0,
                           y: window.frame.height,
                           width: self.collectionView.frame.width,
                           height: self.collectionView.frame.height)
            }
        } completion: { (isCompleted) in
            if !setting.isKind(of: UITapGestureRecognizer.self)
                && setting.name != .cancel {
                self.homeController?.showControllerForSettings(setting)
            }
        }
    }
}

//MARK: - CollectionView DataSource, Delegate:
extension SettingsLauncher: UICollectionViewDataSource,
                            UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        settings.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =
            collectionView.dequeueReusableCell(withReuseIdentifier: cellId,
                                               for: indexPath) as! SettingsCell
        cell.setting = settings[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        let setting = settings[indexPath.item]
        handleDismiss(setting: setting)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        0
    }
}

//MARK: - CollectionViewDelegateFlowLayout:
extension SettingsLauncher: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        CGSize(width: blackView.frame.width, height: cellHeight)
    }
}
