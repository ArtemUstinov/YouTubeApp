//
//  MenuBar.swift
//  YouTubeApp
//
//  Created by Артём Устинов on 18.01.2021.
//  Copyright © 2021 Artem Ustinov. All rights reserved.
//

import UIKit

class MenuBar: UIView {
    
    //MARK: - UI elements:
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero,
                                  collectionViewLayout: layout)
        cv.backgroundColor = UIColor.getRgb(red: 230,
                                            green: 32,
                                            blue: 31)
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    //MARK: - Properties:
    private let cellId = "cellId"
    private let images = ["home", "trending", "subscriptions", "account"]
    
    var homeController: HomeController?
    
    var horizontalBarLeadingAnchorConstraint: NSLayoutConstraint?
    
    //MARK: - Initializers:
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupCollectionView()
        let selectedIndexPath = IndexPath(item: 0, section: 0)
        collectionView.selectItem(at: selectedIndexPath,
                                  animated: false,
                                  scrollPosition: .left)
        setupHorizontalBar()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupHorizontalBar() {
        let horizontalBarView = UIView()
        horizontalBarView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        horizontalBarView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(horizontalBarView)
        
        horizontalBarLeadingAnchorConstraint =
            horizontalBarView.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        horizontalBarLeadingAnchorConstraint?.isActive = true
        
        NSLayoutConstraint.activate([
            horizontalBarView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            horizontalBarView.widthAnchor.constraint(equalTo: self.widthAnchor,
                                                     multiplier: 1 / 4),
            horizontalBarView.heightAnchor.constraint(equalToConstant: 4)
        ])
    }
    
    //MARK: - Setup CollectionView:
    private func setupCollectionView() {
        collectionView.register(MenuCell.self,
                                forCellWithReuseIdentifier: cellId)
        addSubview(collectionView)
        collectionView.addConstraintsWithFormat(format: "H:|[v0]|",
                                                views: [collectionView])
        collectionView.addConstraintsWithFormat(format: "V:|[v0]|",
                                                views: [collectionView])
    }
}

//MARK: - CollectinView Delegate,DataSource:
extension MenuBar: UICollectionViewDelegate,
                   UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        4
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        
        guard let cell =
            collectionView.dequeueReusableCell(withReuseIdentifier: cellId,
                                               for: indexPath) as? MenuCell else {
            fatalError("Don't have 'MenuCell'")
        }
        cell.imageView.image =
            UIImage(named: images[indexPath.item])?.withRenderingMode(.alwaysTemplate)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
//        let x = CGFloat(indexPath.item) * frame.width / 4
//        print(x)
//        horizontalBarLeadingAnchorConstraint?.constant = x
        
//        UIView.animate(withDuration: 0.75,
//                       delay: 0,
//                       usingSpringWithDamping: 1,
//                       initialSpringVelocity: 1,
//                       options: .curveEaseOut,
//                       animations: {
//                        self.layoutIfNeeded()
//                       }, completion: nil)
        
        homeController?.scrollToMenuIndex(indexPath.item)
    }
}

//MARK: - CollectionViewDelegateFlowLayout:
extension MenuBar: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        
        CGSize(width: frame.width / 4, height: frame.height)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        0
    }
}
