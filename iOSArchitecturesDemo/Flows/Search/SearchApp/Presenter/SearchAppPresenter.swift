//
//  SearchAppPresenter.swift
//  iOSArchitecturesDemo
//
//  Created by Alexander Rubtsov on 24.06.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import Foundation
import UIKit

protocol SearchAppViewInput: class {
    var searchResults: [ITunesApp] { get set }
    
    func showError(error: Error)
    func showNoResults()
    func hideNoResults()
    func throbber(show: Bool)
}

protocol SearchAppViewOutput: class {
    func viewDidSearch(with query: String)
    func viewDidSelectApp(_ app: ITunesApp)
}

class SearchAppPresenter {
    
    weak var viewInput: (UIViewController & SearchAppViewInput)?
    
    private let searchService = ITunesSearchService()
    
    private func requestApps(with query: String) {
        self.searchService.getApps(forQuery: query) { [weak self] result in
            guard let self = self else {
                return
            }
            
            self.viewInput?.throbber(show: false)
            result.withValue { apps in
                guard !apps.isEmpty else {
                    self.viewInput?.showNoResults()
                    return
                }
                self.viewInput?.hideNoResults()
                self.viewInput?.searchResults = apps
            } .withError {
                self.viewInput?.showError(error: $0)
            }
        }
    }
    
    private func openAppDetails(with app: ITunesApp) {
        let appDetailsViewController = AppDetailViewController(app: app)
        viewInput?.navigationController?.pushViewController(appDetailsViewController, animated: true)
    }
}

extension SearchAppPresenter: SearchAppViewOutput {
    func viewDidSearch(with query: String) {
        viewInput?.throbber(show: true)
        requestApps(with: query)
    }
    
    func viewDidSelectApp(_ app: ITunesApp) {
        openAppDetails(with: app)
    }
}
