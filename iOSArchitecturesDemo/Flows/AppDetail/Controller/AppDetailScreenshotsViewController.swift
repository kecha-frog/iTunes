//
//  AppDetailScreenshots.swift
//  iOSArchitecturesDemo
//
//  Created by Ke4a on 02.07.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import UIKit

class AppDetailScreenshotsViewController: UIViewController {
    
    // MARK: - Visual Components

    lazy var appDetailScreenshotsView = AppDetailScreenshotsView()

    // MARK: - Private Properties

    private let imageDownloader = ImageDownloader()

    private let app: ITunesApp

    // MARK: - Init

    init(app: ITunesApp) {
        self.app = app
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func loadView() {
        super.loadView()
        self.view = appDetailScreenshotsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        appDetailScreenshotsView.collectionView.dataSource = self
        appDetailScreenshotsView.collectionView.delegate = self

        appDetailScreenshotsView.collectionView.register(AppDetailScreenshotsCell.self, forCellWithReuseIdentifier: AppDetailScreenshotsCell.identifier)
    }

}

// MARK: - UICollectionViewDelegateFlowLayout

extension AppDetailScreenshotsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = appDetailScreenshotsView.frame.height - 44
        return CGSize(width: height / 1.775, height: height)
    }
}

// MARK: - UICollectionViewDataSource

extension AppDetailScreenshotsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        app.screenshotUrls.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = appDetailScreenshotsView.collectionView.dequeueReusableCell(withReuseIdentifier: AppDetailScreenshotsCell.identifier, for: indexPath) as? AppDetailScreenshotsCell else { return UICollectionViewCell() }
        let url = app.screenshotUrls[indexPath.row]
        imageDownloader.getImage(fromUrl:url ) { (image, _) in
            cell.configure(image)
        }
    
        return cell
    }
}
