//
//  AppDetailViewController.swift
//  iOSArchitecturesDemo
//
//  Created by ekireev on 20.02.2018.
//  Copyright © 2018 ekireev. All rights reserved.
//

import UIKit

final class AppDetailViewController: UIViewController {

    // MARK: - Visual Components

    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsVerticalScrollIndicator = true
        view.showsHorizontalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()

    // MARK: - Public Properties

    public var app: ITunesApp

    private lazy var headerViewController = AppDetailHeaderViewController(app: self.app)
    private lazy var descriptionViewController = AppDetailDescriptionViewController(app: self.app)
    private lazy var screenshotsViewController = AppDetailScreenshotsViewController(app: self.app)

    // MARK: - Initialization

    init(app: ITunesApp) {
        self.app = app
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
    }

    // MARK: - Private

    private func configureUI() {
        view.backgroundColor = .white
        self.navigationController?.navigationBar.tintColor = UIColor.white;
        self.navigationItem.largeTitleDisplayMode = .never

        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        ])

        scrollView.addSubview(contentView)
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
            contentView.heightAnchor.constraint(greaterThanOrEqualTo: scrollView.frameLayoutGuide.heightAnchor)
        ])


        addHeaderViewController()
        addDescriptionViewController()
        addScreenshotsViewController()
    }


    private func addHeaderViewController() {
        addChild(headerViewController)
        contentView.addSubview(headerViewController.view)
        headerViewController.didMove(toParent: self)

        headerViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.headerViewController.view.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.headerViewController.view.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.headerViewController.view.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
        ])
    }

    private func addDescriptionViewController() {
        addChild(descriptionViewController)
        contentView.addSubview(descriptionViewController.view)
        descriptionViewController.didMove(toParent: self)

        descriptionViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.descriptionViewController.view.topAnchor.constraint(equalTo: self.headerViewController.view.bottomAnchor),
            self.descriptionViewController.view.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.descriptionViewController.view.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
        ])
    }

    private func addScreenshotsViewController() {
        addChild(screenshotsViewController)
        contentView.addSubview(screenshotsViewController.view)
        screenshotsViewController.didMove(toParent: self)

        screenshotsViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.screenshotsViewController.view.topAnchor.constraint(equalTo: self.descriptionViewController.view.bottomAnchor),
            self.screenshotsViewController.view.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.screenshotsViewController.view.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.screenshotsViewController.view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            self.screenshotsViewController.view.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
}
