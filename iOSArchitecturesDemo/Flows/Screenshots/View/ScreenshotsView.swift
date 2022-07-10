//
//  ScreenshotsView.swift
//  iOSArchitecturesDemo
//
//  Created by Ke4a on 10.07.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import UIKit

class ScreenshotsView: UIView {
    
    // MARK: - Visual Components

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()

        let spancing: CGFloat = 1

        layout.minimumInteritemSpacing = spancing
        layout.minimumLineSpacing = spancing
        layout.scrollDirection = .horizontal

        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.layer.cornerRadius = 25
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)

        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        backgroundColor = .lightGray.withAlphaComponent(0.7)
        isOpaque = false

        addSubview(collectionView)

        let height = frame.height - 300
        let width = height / 1.775


        NSLayoutConstraint.activate([
            collectionView.centerXAnchor.constraint(equalTo: centerXAnchor),
            collectionView.centerYAnchor.constraint(equalTo: centerYAnchor),
            collectionView.widthAnchor.constraint(equalToConstant: width),
            collectionView.heightAnchor.constraint(equalToConstant: height)
        ])
    }
}
