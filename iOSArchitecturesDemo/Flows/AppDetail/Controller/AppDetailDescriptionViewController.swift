//
//  AppDetailDescriptionViewController.swift
//  iOSArchitecturesDemo
//
//  Created by Ke4a on 02.07.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import UIKit

class AppDetailDescriptionViewController: UIViewController {
    // MARK: - Visual Components

    private var appDetailDescriptionView = AppDetailDescriptionView()

    // MARK: - Private Properties
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
        self.view = appDetailDescriptionView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        fillData()
    }
    
    // MARK: - Private Methods

    private func fillData() {
        guard
            let version = app.appVersion,
            let updateDate = app.appUpdateReleaseDate, let date = DateFormatter.decode.date(from: updateDate),
            let description = app.appDescription
        else { return }

        appDetailDescriptionView.configure(
            appVersion: version,
            appUpdateDate: DateFormatter.encode.string(from: date),
            updateDescription: description)
    }
}
