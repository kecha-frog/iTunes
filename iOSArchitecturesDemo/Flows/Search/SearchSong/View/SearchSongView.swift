//
//  SearchSongView.swift
//  iOSArchitecturesDemo
//
//  Created by Ke4a on 06.07.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import UIKit

final class SearchSongView: UIView {

    // MARK: - Visual Components

    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.searchBarStyle = .minimal
        return searchBar
    }()

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()

        let spancing: CGFloat = 1

        layout.minimumInteritemSpacing = spancing
        layout.minimumLineSpacing = spancing
        let width = (UIScreen.main.bounds.width / 3) - (2 * 2)
        layout.itemSize = CGSize(width: width, height: 220)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        //view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var emptyResultView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.isHidden = true
        return view
    }()

    lazy var emptyResultLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Nothing was found"
        label.textColor = UIColor.darkGray
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12.0)
        return label
    }()

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupUI()
    }

    // MARK: - Setting UI Methods

    private func setupUI() {

        self.backgroundColor = .white

        let safeArea = self.safeAreaLayoutGuide

        self.addSubview(self.searchBar)
        NSLayoutConstraint.activate([
            self.searchBar.topAnchor.constraint(equalTo: self.topAnchor, constant: 8.0),
            self.searchBar.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.searchBar.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
        ])

        self.addSubview(collectionView)
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor),
            self.collectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
        ])

        self.addSubview(self.emptyResultView)
        NSLayoutConstraint.activate([
            self.emptyResultView.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor),
            self.emptyResultView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.emptyResultView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.emptyResultView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),

        ])

        self.emptyResultView.addSubview(self.emptyResultLabel)
        NSLayoutConstraint.activate([
            self.emptyResultLabel.topAnchor.constraint(equalTo: self.emptyResultView.topAnchor, constant: 12.0),
            self.emptyResultLabel.leadingAnchor.constraint(equalTo: self.emptyResultView.leadingAnchor),
            self.emptyResultLabel.trailingAnchor.constraint(equalTo: self.emptyResultView.trailingAnchor)
        ])
    }
}
