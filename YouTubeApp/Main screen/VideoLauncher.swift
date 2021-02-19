//
//  VideoLauncher.swift
//  YouTubeApp
//
//  Created by Артём Устинов on 19.02.2021.
//  Copyright © 2021 Artem Ustinov. All rights reserved.
//

import UIKit
import AVKit

class VideoPlayerView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .black
        
        guard let url = URL(string: "https://firebasestorage.googleapis.com/v0/b/gameofchats-762ca.appspot.com/o/message_movies%2F12323439-9729-4941-BA07-2BAE970967C7.mov?alt=media&token=3e37a093-3bc8-410f-84d3-38332af9c726") else { return }
        let avPlayer = AVPlayer(url: url)
        let playerLayer = AVPlayerLayer(player: avPlayer)
        playerLayer.frame = self.frame
        layer.addSublayer(playerLayer)
        avPlayer.play()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class VideoLauncher {
    
    
    
    func showVideoPlayer() {
        if let keyWindow =
            UIApplication.shared.windows.filter({$0.isKeyWindow}).first {
            let view = UIView(frame: keyWindow.frame)
            view.backgroundColor = .white
            view.frame = CGRect(x: keyWindow.frame.width - 10,
                                y: keyWindow.frame.height - 10,
                                width: 10,
                                height: 10)
            
            let videoHeight = keyWindow.frame.width * 9 / 16
            let videoPlayerFrame = CGRect(x: 0,
                                          y: 0,
                                          width: keyWindow.frame.width,
                                          height: videoHeight)
            let videoPlayer = VideoPlayerView(frame: videoPlayerFrame)
            view.addSubview(videoPlayer)
            
            keyWindow.addSubview(view)
            
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 1,
                           initialSpringVelocity: 1,
                           options: .curveEaseOut) {
                
                view.frame = keyWindow.frame
            } completion: { isCompleted in
                
                UIApplication.shared.isStatusBarHidden = true
                
            }
        }
    }
}
