//
//  FeedCell.swift
//  YouTubeApp
//
//  Created by Артём Устинов on 19.02.2021.
//  Copyright © 2021 Artem Ustinov. All rights reserved.
//

import UIKit

class FeedCell: BaseCell {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView =
            UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    var videos = [Video]()
    let networkManager = NetworkManager()
    
    
    private let cellId = "CellId "
    
    override func setupViews() {
        super.setupViews()
        
        setupCollectionView()
        
        fetchDataVideo()
        
    }
    
    func fetchDataVideo() {
        networkManager.fetchVideo(url: .home) {
            [weak self] videos in
            self?.videos = videos
            self?.collectionView.reloadData()
        }
    }
    
    private func setupCollectionView() {
        collectionView.register(VideoCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    override func setupLayouts() {
        addSubview(collectionView)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: [collectionView])
        addConstraintsWithFormat(format: "V:|[v0]|", views: [collectionView])
    }
    
}

extension FeedCell: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        videos.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        
        guard let cell =
                collectionView.dequeueReusableCell(
                    withReuseIdentifier: cellId,
                    for: indexPath
                ) as? VideoCell else {
            fatalError("Don't have 'VideoCell'")
        }
        cell.video = videos[indexPath.item]
        
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

extension FeedCell: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        var height = (frame.width - 16 - 16) * 9 / 16
        height += 16 + 88
        return CGSize(width: frame.width, height: height)
    }
}
