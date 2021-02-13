//
//  ViewController.swift
//  YouTubeApp
//
//  Created by Артём Устинов on 13.01.2021.
//  Copyright © 2021 Artem Ustinov. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController {
    
    private let menuBarView = MenuBar()
    
    
    //MARK: - Override methods:
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let navTitleLabel = UILabel(frame: CGRect(x: 0,
                                                  y: 0,
                                                  width: view.frame.width - 32,
                                                  height: view.frame.height))

        
        navigationItem.title = "Home"
        navigationController?.navigationBar.isTranslucent = false
        navTitleLabel.text = "Home"
        navTitleLabel.textColor = .white
        navTitleLabel.font = .systemFont(ofSize: 20)
        navigationItem.titleView = navTitleLabel
        
        collectionView.backgroundColor = .white
        
        collectionView.register(VideoCell.self,
                                forCellWithReuseIdentifier: "Cell")
        
        setupMenuBar()
    }
    
    private func setupMenuBar() {
        view.addSubview(menuBarView)
        view.addConstraintsWithFormat(format: "H:|[v0]|",
                                      views: [menuBarView])
        view.addConstraintsWithFormat(format: "V:|[v0(50)]",
        views: [menuBarView])
    }
    
    override func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        5
    }
    
    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        
        let cell =
            collectionView.dequeueReusableCell(
                withReuseIdentifier: "Cell",
                for: indexPath
        )
        
        return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        0
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension HomeController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        var height = (view.frame.width - 16 - 16) * 9 / 16
        height += 16 + 68
        return CGSize(width: view.frame.width, height: height)
    }
}

