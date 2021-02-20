//
//  VideoPlayerView.swift
//  YouTubeApp
//
//  Created by Артём Устинов on 21.02.2021.
//  Copyright © 2021 Artem Ustinov. All rights reserved.
//

import UIKit
import AVKit

class VideoPlayerView: UIView {
    
    //MARK: - UI elements:
    private let controlsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 1)
        return view
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .large)
        activity.color = .white
        activity.translatesAutoresizingMaskIntoConstraints = false
        activity.startAnimating()
        return activity
    }()
    
    private let pausePlayButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(named: "pause")
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        button.isHidden = true
        
        button.addTarget(self,
                         action: #selector(handlePause),
                         for: .touchUpInside)
        return button
    }()
    
    private let videoLengthLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "00:00"
        label.font = .boldSystemFont(ofSize: 13)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let currentTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "00:00"
        label.font = .boldSystemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let videoSlider: UISlider = {
        let slider = UISlider()
        slider.minimumTrackTintColor = .red
        slider.maximumTrackTintColor = .white
        slider.thumbTintColor = .red
        slider.translatesAutoresizingMaskIntoConstraints = false
        
        slider.addTarget(self,
                         action: #selector(handleSliderChanged),
                         for: .valueChanged)
        return slider
    }()
    
    //MARK: - Properties:
    private var avPlayer: AVPlayer?
    private var isPlaying = true
    
    //MARK: - Initializers:
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupPlayerView()
        
        controlsContainerView.frame = frame
        addSubview(controlsContainerView)
        
        setupLayouts()
        
        setupGradientLayer()
        backgroundColor = .black
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Override methods:
    override func observeValue(forKeyPath keyPath: String?,
                               of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?,
                               context: UnsafeMutableRawPointer?) {
        
        if keyPath == "currentItem.loadedTimeRanges" {
            activityIndicator.stopAnimating()
            controlsContainerView.backgroundColor = .clear
            
            pausePlayButton.isHidden = false
            
            if let duration = avPlayer?.currentItem?.duration {
                let durationSeconds = CMTimeGetSeconds(duration)
                let secondsText = Int(durationSeconds) % 60
                let minutesText = String(format: "%02d",
                                         Int(durationSeconds) / 60)
                
                self.videoLengthLabel.text = "\(minutesText):\(secondsText)"
            }
        }
    }
    
    //MARK: - @objc methods:
    @objc private func handlePause() {
        if isPlaying {
            avPlayer?.pause()
            pausePlayButton.setImage(UIImage(named: "play"), for: .normal)
        } else {
            avPlayer?.play()
            pausePlayButton.setImage(UIImage(named: "pause"), for: .normal)
        }
        isPlaying = !isPlaying
    }
    
    @objc private func handleSliderChanged() {
        
        if let duration = avPlayer?.currentItem?.duration {
            let totalSeconds = CMTimeGetSeconds(duration)
            let sliderValue = Float64(videoSlider.value) * totalSeconds
            
            let seekTime = CMTime(value: Int64(sliderValue), timescale: 1)
            
            avPlayer?.seek(to: seekTime, completionHandler: { completed in
                print(self.videoSlider.value)
            })
        }
        
    }
    
    //MARK: - Setup PlayerView:
    private func setupPlayerView() {
        guard let url = URL(string: "https://firebasestorage.googleapis.com/v0/b/gameofchats-762ca.appspot.com/o/message_movies%2F12323439-9729-4941-BA07-2BAE970967C7.mov?alt=media&token=3e37a093-3bc8-410f-84d3-38332af9c726") else { return }
        avPlayer = AVPlayer(url: url)
        let playerLayer = AVPlayerLayer(player: avPlayer)
        playerLayer.frame = self.frame
        layer.addSublayer(playerLayer)
        avPlayer?.play()
        
        avPlayer?.addObserver(self,
                              forKeyPath: "currentItem.loadedTimeRanges",
                              options: .new,
                              context: nil)
        
        let interval = CMTime(value: 1, timescale: 2)
        avPlayer?.addPeriodicTimeObserver(
            forInterval: interval,
            queue: .main,
            using: { progressTime in
                let seconds = Int(CMTimeGetSeconds(progressTime))
                let secondsString = String(format: "%02d", seconds % 60)
                let minutesString = String(format: "%02d", seconds / 60)
                self.currentTimeLabel.text = "\(minutesString):\(secondsString)"
                
                if let duration = self.avPlayer?.currentItem?.duration {
                    let durationSeconds = CMTimeGetSeconds(duration)
                    self.videoSlider.value =
                        Float(seconds) / Float(durationSeconds)
                }
            }
        )
    }
    
    //MARK: - Setup GradientLayer:
    private func setupGradientLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.7, 1.2]
        
        controlsContainerView.layer.addSublayer(gradientLayer)
    }
    
    //MARK: - Setup Layouts:
    private func setupLayouts() {
        controlsContainerView.addSubview(activityIndicator)
        controlsContainerView.addSubview(pausePlayButton)
        controlsContainerView.addSubview(videoLengthLabel)
        controlsContainerView.addSubview(currentTimeLabel)
        controlsContainerView.addSubview(videoSlider)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            pausePlayButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            pausePlayButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            pausePlayButton.widthAnchor.constraint(equalToConstant: 50),
            pausePlayButton.heightAnchor.constraint(equalToConstant: 50),
            
            videoLengthLabel.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                       constant: -8),
            videoLengthLabel.bottomAnchor.constraint(equalTo: bottomAnchor,
                                                     constant: -2),
            videoLengthLabel.widthAnchor.constraint(equalToConstant: 50),
            videoLengthLabel.heightAnchor.constraint(equalToConstant: 24),
            
            currentTimeLabel.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                      constant: 8),
            currentTimeLabel.bottomAnchor.constraint(equalTo: bottomAnchor,
                                                     constant: -2),
            currentTimeLabel.widthAnchor.constraint(equalToConstant: 50),
            currentTimeLabel.heightAnchor.constraint(equalToConstant: 24),
            
            videoSlider.trailingAnchor.constraint(equalTo: videoLengthLabel.leadingAnchor),
            videoSlider.bottomAnchor.constraint(equalTo: bottomAnchor),
            videoSlider.leadingAnchor.constraint(equalTo: currentTimeLabel.trailingAnchor),
            videoSlider.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}
