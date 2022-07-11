//
//  SearchSongPresenter.swift
//  iOSArchitecturesDemo
//
//  Created by Ke4a on 06.07.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import UIKit

// MARK: - Protocol Interactor Input | Output

protocol SearchSongViewInput: class {
    var searchResults: [ITunesSong] { get set }

    func showError(error: Error)
    func showNoResults()
    func hideNoResults()
    func throbber(show: Bool)
}

protocol SearchSongViewOutput: class {
    func getCellModel(from song: ITunesSong, completion: @escaping (_ cellModel: SearchSongCellModel)-> Void)
    func viewDidSearch(with query: String)
    func viewDidSelectSong(_ song: ITunesSong)
}

// MARK: - Cell Model

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
    private let interactor: SearchSongInteractorInput
    private let router: SearchSongRouterInput

    // MARK: - Initialization

    init(interactor: SearchSongInteractorInput, router: SearchSongRouterInput){
        self.interactor = interactor
        self.router = router
    }
}

// MARK: - SearchSongViewOutput

extension SearchSongPresenter: SearchSongViewOutput {
    func getCellModel(from song: ITunesSong, completion: @escaping (SearchSongCellModel) -> Void) {
        DispatchQueue.main.async {
            self.interactor.convertToCellModel(from: song, completion: completion)
        }
    }

    func viewDidSearch(with query: String) {
        viewInput?.throbber(show: true)

        if #available(iOS 13.0, *) {
            Task{ @MainActor [weak self] in
                guard let self = self else { return }

                let result = await interactor.requestSong(with: query)
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
        } else {
            interactor.requestSong(with: query) { [weak self] result in
                guard let self = self else { return }

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

    func viewDidSelectSong(_ song: ITunesSong) {
        router.openSong(song)
    }
}
