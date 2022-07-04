//
//  AppDetailScreenshotsCell.swift
//  iOSArchitecturesDemo
//
//  Created by Ke4a on 02.07.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import Foundation
import UIKit

class AppDetailScreenshotsCell: UICollectionViewCell {
    // MARK: - Visual Components

    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - Static Properties

    static var identifier = "AppDetailScreenshotsCell"

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setting UI Methods

    private func setupUI() {
        contentView.addSubview(imageView)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }

    // MARK: - Public Methods
    
    func configure(_ image: UIImage?){
        imageView.image = image
    }
}
