//
//  AppDetailDescriptionView.swift
//  iOSArchitecturesDemo
//
//  Created by Ke4a on 02.07.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import Foundation
import UIKit

class AppDetailDescriptionView: UIView {

    // MARK: - Visual Components

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Что нового"
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        return label
    }()

    private lazy var versionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16.0)
        label.textColor = .lightGray
        return label
    }()

    private lazy var updateDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 16.0)
        label.textColor = .lightGray
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setting UI Methods

    private func setupUI(){
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])

        addSubview(versionLabel)
        NSLayoutConstraint.activate([
            versionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            versionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            versionLabel.widthAnchor.constraint(equalToConstant: 200)
        ])

        addSubview(updateDateLabel)
        NSLayoutConstraint.activate([
            updateDateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            updateDateLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            updateDateLabel.widthAnchor.constraint(equalToConstant: 200)
        ])

        addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: versionLabel.bottomAnchor, constant: 12),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -12)
        ])
    }

    // MARK: - Public Methods
    
    func configure(appVersion: String, appUpdateDate: String, updateDescription: String){
        versionLabel.text = appVersion
        updateDateLabel.text = appUpdateDate
        descriptionLabel.text = updateDescription
    }
}
