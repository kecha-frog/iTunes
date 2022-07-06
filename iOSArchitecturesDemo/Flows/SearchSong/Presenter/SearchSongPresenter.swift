//
//  SearchSongPresenter.swift
//  iOSArchitecturesDemo
//
//  Created by Ke4a on 06.07.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import UIKit

protocol SearchSongViewInput: class {
    var searchResults: [ITunesSong] { get set }

    func showError(error: Error)
    func showNoResults()
    func hideNoResults()
    func throbber(show: Bool)
}

protocol SearchSongViewOutput: class {
    func viewDidSearch(with query: String)
    func getCellModel(from model: ITunesSong, completion: @escaping (_ cellModel: SearchSongCellModel)-> Void)
}

struct SearchSongCellModel {
    var trackName: String
    var artistName: String?
    var image: UIImage?
}

class SearchSongPresenter {

    // MARK: - Public Properties

    weak var viewInput: (UIViewController & SearchSongViewInput)?

    // MARK: - Private Properties

    private let searchService = ITunesSearchService()
    private let looaderImage = ImageDownloader()

    // MARK: - Private Methods

    private func requestApps(with query: String) {
        self.searchService.getSongs(forQuery: query) { [weak self] result in
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
}

// MARK: - SearchSongViewOutput

extension SearchSongPresenter: SearchSongViewOutput {
    func viewDidSearch(with query: String) {
        viewInput?.throbber(show: true)
        requestApps(with: query)
    }

    func getCellModel(from model: ITunesSong, completion: @escaping (_ cellModel: SearchSongCellModel)-> Void)  {


        guard let url = model.artwork else {
            let cell = SearchSongCellModel(trackName: model.trackName,
                                           artistName: model.artistName,
                                           image: nil)
            DispatchQueue.main.async {
                completion(cell)
            }

            return
        }

        // Из за того что сделан на замыкание, пришлось делать черз замыкание.
        looaderImage.getImage(fromUrl: url) { image, error in
            let cell = SearchSongCellModel(trackName: model.trackName,
                                           artistName: model.artistName,
                                           image: image)
            DispatchQueue.main.async {
                completion(cell)
            }
        }
    }
}
