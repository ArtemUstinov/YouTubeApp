//
//  ViewController.swift
//  YouTubeApp
//
//  Created by Артём Устинов on 13.01.2021.
//  Copyright © 2021 Artem Ustinov. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController {
    
    private lazy var menuBarView: MenuBar = {
        let menuBar = MenuBar()
        menuBar.homeController = self
        return menuBar
    }()
    
    private var videos = [Video]()
    
    private let networkManager = NetworkManager()
    
    private lazy var settingsLauncher: SettingsLauncher = {
        let launcher = SettingsLauncher()
        launcher.homeController = self
        return launcher
    }()
    
    let cellId = "Cell id"
    
    //MARK: - Override methods:
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let navTitleLabel = UILabel(frame: CGRect(x: 0,
                                                  y: 0,
                                                  width: view.frame.width - 32,
                                                  height: view.frame.height))
        
        
//        navigationItem.title = "  Home"
        navigationController?.navigationBar.isTranslucent = false
        navTitleLabel.text = "  Home"
        navTitleLabel.textColor = .white
        navTitleLabel.font = .systemFont(ofSize: 20)
        navigationItem.titleView = navTitleLabel
        
        setupCollectionView()
        
        setupMenuBar()
        setupNavBar()
        
        fetchDataVideo()
    }
    
    private func fetchDataVideo() {
        networkManager.fetchVideo {
            [weak self] videos in
            self?.videos = videos
            self?.collectionView.reloadData()
        }
    }

    private func setupCollectionView() {
        if let flowLayout =
            collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        collectionView.backgroundColor = .white
        
//        collectionView.register(VideoCell.self,
//                                forCellWithReuseIdentifier: "Cell")
        
        collectionView.register(UICollectionViewCell.self,
                                forCellWithReuseIdentifier: cellId)
        
        collectionView.contentInset = UIEdgeInsets(top: 50,
                                                   left: 0,
                                                   bottom: 0,
                                                   right: 0)
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 50,
                                                            left: 0,
                                                            bottom: 0,
                                                            right: 0)
        
        collectionView.isPagingEnabled = true
    }
    
    func scrollToMenuIndex(_ index: Int) {
        let indexPath = IndexPath(item: index, section: 0)
        collectionView.isPagingEnabled = false
        collectionView.scrollToItem(at: indexPath,
                                    at: .left,
                                    animated: true)
        collectionView.isPagingEnabled = true
    }
    
    private func setupMenuBar() {
        navigationController?.hidesBarsOnSwipe = true
        
        let redView = UIView()
        redView.backgroundColor = UIColor.getRgb(red: 230,
                                                 green: 32,
                                                 blue: 31)
        view.addSubview(redView)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: [redView])
        view.addConstraintsWithFormat(format: "V:[v0(50)]", views: [redView])
        
        view.addSubview(menuBarView)
        view.addConstraintsWithFormat(format: "H:|[v0]|",
                                      views: [menuBarView])
        view.addConstraintsWithFormat(format: "V:[v0(50)]",
                                      views: [menuBarView])
        
        menuBarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
                                         
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
        dummySettingsVC.title = setting.name.rawValue
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.pushViewController(dummySettingsVC,
                                                 animated: true)
    }
    
    @objc private func searchHandle() {
    }
    
    @objc private func moreHandle() {
        settingsLauncher.showSettings()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId,
                                                      for: indexPath)
        
        let cells: [UIColor] = [.blue, .brown, .cyan, .green]
        cell.backgroundColor = cells[indexPath.item]
        return cell
    }

    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menuBarView.horizontalBarLeadingAnchorConstraint?.constant =
            scrollView.contentOffset.x / 4
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView,
                                            withVelocity velocity: CGPoint,
                                            targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let index = targetContentOffset.pointee.x / view.frame.width
        let indexPath = IndexPath(item: Int(index), section: 0)
        menuBarView.collectionView.selectItem(at: indexPath,
                                              animated: true,
                                              scrollPosition: .left)
    }
    
//    override func collectionView(
//        _ collectionView: UICollectionView,
//        numberOfItemsInSection section: Int
//    ) -> Int {
//        videos.count
//    }
//
//    override func collectionView(
//        _ collectionView: UICollectionView,
//        cellForItemAt indexPath: IndexPath
//    ) -> UICollectionViewCell {
//
//        guard let cell =
//                collectionView.dequeueReusableCell(
//                    withReuseIdentifier: "Cell",
//                    for: indexPath
//                ) as? VideoCell else {
//            fatalError("Don't have 'VideoCell'")
//        }
//        cell.video = videos[indexPath.item]
//
//        return cell
//    }
//
//    func collectionView(
//        _ collectionView: UICollectionView,
//        layout collectionViewLayout: UICollectionViewLayout,
//        minimumLineSpacingForSectionAt section: Int
//    ) -> CGFloat {
//        0
//    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension HomeController: UICollectionViewDelegateFlowLayout {
    
//    func collectionView(
//        _ collectionView: UICollectionView,
//        layout collectionViewLayout: UICollectionViewLayout,
//        sizeForItemAt indexPath: IndexPath
//    ) -> CGSize {
//        var height = (view.frame.width - 16 - 16) * 9 / 16
//        height += 16 + 88
//        return CGSize(width: view.frame.width, height: height)
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: view.frame.width, height: view.frame.height)
    }
}

