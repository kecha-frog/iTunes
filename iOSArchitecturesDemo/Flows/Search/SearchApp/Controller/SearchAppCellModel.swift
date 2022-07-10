//
//  SearchAppCellModel.swift
//  iOSArchitecturesDemo
//
//  Created by Evgeny Kireev on 02/06/2019.
//  Copyright © 2019 ekireev. All rights reserved.
//

import Foundation

struct SearchAppCellModel {
    let title: String
    let subtitle: String?
    let rating: String?
}

final class SearchAppCellModelFactory {
    static func cellModel(from model: ITunesApp) -> SearchAppCellModel {
        return SearchAppCellModel(title: model.appName,
                            subtitle: model.company,
                            rating: model.averageRating >>- { "\($0)" })
    }
}
