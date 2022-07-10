//
//  ScreenshotsViewController.swift
//  iOSArchitecturesDemo
//
//  Created by Ke4a on 04.07.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import UIKit

class ScreenshotsViewController: UIViewController {

    private var screenshotView: ScreenshotsView {
        return self.view as! ScreenshotsView
    }

    // MARK: - Private Properties

    private let imageDownloader = ImageDownloader()

    private let data: [String]
    private var cache: [String: UIImage?]

    // MARK: - Initialization

    init(_  urls: [String], _ cache: [String: UIImage?]) {
        self.data = urls
        self.cache = cache
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()
        self.view = ScreenshotsView(frame: view.frame)
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        addTapGestureRecognizer()
        screenshotView.collectionView.delegate = self
        screenshotView.collectionView.dataSource = self
        screenshotView.collectionView.register(ScreenshotsCell.self, forCellWithReuseIdentifier: ScreenshotsCell.identifier)
    }

    

    // MARK: - Private Methods

    private func addTapGestureRecognizer() {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(actionTapView))
        view.addGestureRecognizer(gestureRecognizer)
    }

    @objc func actionTapView(_ gestureRecognizer: UITapGestureRecognizer){
        let touchPoint = gestureRecognizer.location(in: view)

        guard !screenshotView.collectionView.frame.contains(touchPoint) else { return }

        dismiss(animated: true)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ScreenshotsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.frame.height
        return CGSize(width: height / 1.775, height: height)
    }
}

// MARK: - UICollectionViewDataSource

extension ScreenshotsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ScreenshotsCell.identifier, for: indexPath) as? ScreenshotsCell else { return UICollectionViewCell() }

        let url = data[indexPath.row]
        
        if let image = cache[url] {
            cell.configure(image)
        } else {
            imageDownloader.getImage(fromUrl:url ) { [weak self ] (image, _) in
                self?.cache[url] = image
                cell.configure(image)
            }
        }
        return cell
    }
}
