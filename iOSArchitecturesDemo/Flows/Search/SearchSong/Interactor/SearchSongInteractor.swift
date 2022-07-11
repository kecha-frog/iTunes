//
//  SearchSongInteractor.swift
//  iOSArchitecturesDemo
//
//  Created by Ke4a on 10.07.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import Foundation
import Alamofire

// MARK: - Protocol Interactor Input

protocol SearchSongInteractorInput {
    @available(iOS 13.0.0, *) func requestSong(with query: String) async -> Result<[ITunesSong]>

    func requestSong(with query: String, completion: @escaping (Result<[ITunesSong]>) -> Void)

    func convertToCellModel(from song: ITunesSong, completion: @escaping (_ cellModel: SearchSongCellModel)-> Void)
}

final class SearchSongInteractor: SearchSongInteractorInput {

    // MARK: - Private Properties

    private let searchService = ITunesSearchService()
    private let looaderImage = ImageDownloader()

    // MARK: - Public Methods

    @available(iOS 13.0.0, *)
    func requestSong(with query: String) async -> Result<[ITunesSong]> {
        return await withCheckedContinuation { continuation in
            self.searchService.getSongs(forQuery: query) { result in
                continuation.resume(returning: result)
            }
        }
    }

    func requestSong(with query: String, completion: @escaping (Result<[ITunesSong]>) -> Void) {
        self.searchService.getSongs(forQuery: query, completion: completion)
    }

    func convertToCellModel(from song: ITunesSong, completion: @escaping (_ cellModel: SearchSongCellModel)-> Void)  {

        guard let url = song.artwork else {
            let cell = SearchSongCellModel(trackName: song.trackName,
                                           artistName: song.artistName,
                                           image: nil)
            completion(cell)

            return
        }

        looaderImage.getImage(fromUrl: url) { image, error in
            let cell = SearchSongCellModel(trackName: song.trackName,
                                           artistName: song.artistName,
                                           image: image)
            completion(cell)
        }
    }
}
