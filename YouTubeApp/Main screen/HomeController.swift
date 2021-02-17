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
    
    //    private let videos: [Video] = {
    //        let kanyeChannel =
    //            Channel(name: "KanyeIsTheBestChannel",
    //                    profileImageName: "kanye_profile")
    //
    //        let blankSpaceVideo =
    //            Video(title: "Taylor Swift - Blank Space",
    //                  thumbnailImageName: "taylor_swift_blank_space",
    //                  numberOfViews: 653453455,
    //                  uploadDate: "2 years ago",
    //                  channel: kanyeChannel
    //                  )
    //        let badBloodVideo =
    //            Video(title: "Taylor Swift - Bad Blood featuring Kendrick Lamar",
    //                  thumbnailImageName: "taylor_swift_bad_blood",
    //                  numberOfViews: 54023414234,
    //                  uploadDate: "1 years ago",
    //                  channel: kanyeChannel)
    //        return [blankSpaceVideo, badBloodVideo]
    //    }()
    
    private var videos = [Video]()
    
    private let networkManager = NetworkManager()
    
    private lazy var settingsLauncher: SettingsLauncher = {
        let launcher = SettingsLauncher()
        launcher.homeController = self
        return launcher
    }()
    
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
        
        collectionView.contentInset = UIEdgeInsets(top: 50,
                                                   left: 0,
                                                   bottom: 0,
                                                   right: 0)
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 50,
                                                            left: 0,
                                                            bottom: 0,
                                                            right: 0)
        
        setupMenuBar()
        setupNavBar()
        
        fetchDataVideo()
    }
    
    private func fetchDataVideo() {
        networkManager.fetchVideo {
            [weak self] jsonData in
            var channel = Channel()
            var video = Video()
            
            for dictionary in jsonData as! [[String: AnyObject]] {
                
                video.title = dictionary["title"] as? String
                video.thumbnailImageName =
                    dictionary["thumbnail_image_name"] as? String
                
                let dictionaryChannel =
                    dictionary["channel"] as? [String: AnyObject]
                
                channel.profileImageName =
                    dictionaryChannel?["profile_image_name"] as? String
                channel.name = dictionaryChannel?["name"] as? String
                
                video.channel = channel
                self?.videos.append(video)
            }
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
    
    private func setupMenuBar() {
        view.addSubview(menuBarView)
        view.addConstraintsWithFormat(format: "H:|[v0]|",
                                      views: [menuBarView])
        view.addConstraintsWithFormat(format: "V:|[v0(50)]",
                                      views: [menuBarView])
    }
    
    private func setupNavBar() {
        let search = UIImage(named: "search_icon")?.withRenderingMode(.alwaysOriginal)
        let searchButton = UIBarButtonItem(image: search,
                                           style: .plain,
                                           target: self,
                                           action: #selector(searchHandle))
        let more = UIImage(named: "nav_more_icon")?.withRenderingMode(.alwaysOriginal)
        let moreButton = UIBarButtonItem(image: more,
                                         style: .plain,
                                         target: self,
                                         action: #selector(moreHandle))
        navigationItem.rightBarButtonItems = [moreButton, searchButton]
    }
    
    func showControllerForSettings(_ setting: Setting) {
        let dummySettingsVC = UIViewController()
        dummySettingsVC.view.backgroundColor = .white
        dummySettingsVC.title = setting.name
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.pushViewController(dummySettingsVC,
                                                 animated: true)
    }
    
    @objc private func searchHandle() {
        print(123)
    }
    
    @objc private func moreHandle() {
        settingsLauncher.showSettings()
    }
    
    override func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        videos.count
    }
    
    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        
        guard let cell =
                collectionView.dequeueReusableCell(
                    withReuseIdentifier: "Cell",
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

//MARK: - UICollectionViewDelegateFlowLayout
extension HomeController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        var height = (view.frame.width - 16 - 16) * 9 / 16
        height += 16 + 88
        return CGSize(width: view.frame.width, height: height)
    }
}

