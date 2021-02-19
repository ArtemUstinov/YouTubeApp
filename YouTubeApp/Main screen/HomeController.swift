//
//  ViewController.swift
//  YouTubeApp
//
//  Created by Артём Устинов on 13.01.2021.
//  Copyright © 2021 Artem Ustinov. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController {
    
    //MARK: - UI elements:
    private lazy var menuBarView: MenuBar = {
        let menuBar = MenuBar()
        menuBar.homeController = self
        return menuBar
    }()
    
    //MARK: - Properties:
    private lazy var settingsLauncher: SettingsLauncher = {
        let launcher = SettingsLauncher()
        launcher.homeController = self
        return launcher
    }()
    
    private let cellId = "Cell id"
    private let titles = ["Home", "Trending", "Subscriptions", "Account"]
    
    //MARK: - Override methods:
    override func viewDidLoad() {
        super.viewDidLoad()
         
        setupNavigationTitle()
        
        setupCollectionView()
        
        setupMenuBar()
        setupNavBar()
        
    }
    
    //MARK: - Setup NavigationTitle:
    private func setupNavigationTitle() {
        let navTitleLabel =
            UILabel(frame: CGRect(x: 0,
                                  y: 0,
                                  width: view.frame.width - 32,
                                  height: view.frame.height))
        
        
        //        navigationItem.title = "  Home"
        navigationController?.navigationBar.isTranslucent = false
        navTitleLabel.text = "  Home"
        navTitleLabel.textColor = .white
        navTitleLabel.font = .systemFont(ofSize: 20)
        navigationItem.titleView = navTitleLabel
    }
    
    //MARK: - Setup NavigationBar:
    private func setupNavBar() {
        let searchImage =
            UIImage(named: "search_icon")?.withRenderingMode(.alwaysOriginal)
        let searchButton =
            UIBarButtonItem(image: searchImage,
                            style: .plain,
                            target: self,
                            action: #selector(searchHandle))
        let moreImage =
            UIImage(named: "nav_more_icon")?.withRenderingMode(.alwaysOriginal)
        let moreButton =
            UIBarButtonItem(image: moreImage,
                            style: .plain,
                            target: self,
                            action: #selector(moreHandle))
        
        navigationItem.rightBarButtonItems = [moreButton, searchButton]
    }
    
    //MARK: - Setup MenuBar:
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
        
        menuBarView.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor
        ).isActive = true
        
    }
    
    //MARK: - Setup CollectionView:
    private func setupCollectionView() {
        if let flowLayout =
            collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        collectionView.backgroundColor = .white
        
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: cellId)
        
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
    
    //MARK: - Scroll settings:
    func scrollToMenuIndex(_ index: Int) {
        let indexPath = IndexPath(item: index, section: 0)
        collectionView.isPagingEnabled = false
        collectionView.scrollToItem(at: indexPath,
                                    at: .left,
                                    animated: true)
        collectionView.isPagingEnabled = true
        
        setTitleForIndex(index)
    }
    
    private func setTitleForIndex(_ index: Int) {
        if let titleLabel = navigationItem.titleView as? UILabel {
            titleLabel.text = "  \(titles[index])"
        }
    }
    
    //MARK: - Setup Settings screen:
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
    
    //MARK: - @objc methods:
    @objc private func searchHandle() {
    }
    
    @objc private func moreHandle() {
        settingsLauncher.showSettings()
    }
}

extension HomeController {
    
    //MARK: - TableViewDataSource:
    override func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        4
    }
    
    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        
        let cell =
            collectionView.dequeueReusableCell(withReuseIdentifier: cellId,
                                               for: indexPath)
        //
        //        let cells: [UIColor] = [.blue, .brown, .cyan, .green]
        //        cell.backgroundColor = cells[indexPath.item]
        return cell
    }
    
    //MARK: - ScrollView methods:
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menuBarView.horizontalBarLeadingAnchorConstraint?.constant =
            scrollView.contentOffset.x / 4
    }
    
    override func scrollViewWillEndDragging(
        _ scrollView: UIScrollView,
        withVelocity velocity: CGPoint,
        targetContentOffset: UnsafeMutablePointer<CGPoint>
    ) {
        let index = targetContentOffset.pointee.x / view.frame.width
        let indexPath = IndexPath(item: Int(index), section: 0)
        menuBarView.collectionView.selectItem(at: indexPath,
                                              animated: true,
                                              scrollPosition: .left)
        
        setTitleForIndex(Int(index))
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension HomeController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        CGSize(width: view.frame.width, height: view.frame.height - 50)
    }
}

