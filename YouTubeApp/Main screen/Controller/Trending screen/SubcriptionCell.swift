//
//  SubcriptionCell.swift
//  YouTubeApp
//
//  Created by Артём Устинов on 19.02.2021.
//  Copyright © 2021 Artem Ustinov. All rights reserved.
//


class SubscriptionCell: FeedCell {
    
    override func fetchDataVideo() {
        networkManager.fetchVideo(url: .subscription) {
            [weak self] videos in
            self?.videos = videos
            self?.collectionView.reloadData()
        }
    }
}

