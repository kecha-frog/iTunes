//
//  SearchSongCell.swift
//  iOSArchitecturesDemo
//
//  Created by Ke4a on 06.07.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import UIKit

class SearchSongCell: UICollectionViewCell {
    // MARK: - Visual Components

    private let songImageView: UIImageView =  {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let artistLabel: UILabel =  {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        return label
    }()

    private let songNameLabel: UILabel =  {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    // MARK: - Static Properties

    static let identifier = "SearchSongCell"

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Prepare For Reuse

    override func prepareForReuse() {
        songImageView.image = nil
        artistLabel.text = nil
        songNameLabel.text = nil
    }

    // MARK: - Setting UI Methods

    private func setupUI() {
        let safeArea = contentView.safeAreaLayoutGuide

        contentView.addSubview(songImageView)
        NSLayoutConstraint.activate([
            songImageView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            songImageView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
        ])

        contentView.addSubview(artistLabel)
        NSLayoutConstraint.activate([
            artistLabel.topAnchor.constraint(equalTo: songImageView.bottomAnchor),
            artistLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            artistLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
        ])
        
        contentView.addSubview(songNameLabel)
        NSLayoutConstraint.activate([
            songNameLabel.topAnchor.constraint(equalTo: artistLabel.bottomAnchor),
            songNameLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            songNameLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
        ])
    }

    // MARK: - Public Methods
    
    func configure(with cellModel: SearchSongCellModel) {
        self.songImageView.image = cellModel.image
        self.artistLabel.text = cellModel.artistName
        self.songNameLabel.text = cellModel.trackName
    }
}
