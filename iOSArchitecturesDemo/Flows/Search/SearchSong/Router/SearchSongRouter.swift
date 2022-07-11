//
//  SearchSongRouter.swift
//  iOSArchitecturesDemo
//
//  Created by Ke4a on 11.07.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import UIKit

protocol SearchSongRouterInput {
    func openSong(_ song: ITunesSong)
}

class SearchSongRouter: SearchSongRouterInput {
    weak var viewController: UIViewController?

    func openSong(_ song: ITunesSong) {
        print((song.artistName ?? "!!!!") as String)
    }
}
