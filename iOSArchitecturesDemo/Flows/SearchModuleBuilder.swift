//
//  SearchModuleBuilder.swift
//  iOSArchitecturesDemo
//
//  Created by Alexander Rubtsov on 24.06.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import UIKit

class SearchModuleBuilder {
    
    // MARK: - Static Methods

    static func appBuild() -> (UIViewController & SearchViewInput) {
        let presenter = SearchPresenter()
        let viewController = SearchViewController(presenter: presenter)
        presenter.viewInput = viewController
        
        return viewController
    }

    static func songBuild() -> (UIViewController & SearchSongViewInput) {
        let presenter = SearchSongPresenter()
        let viewController = SearchSongViewController(presenter: presenter)
        presenter.viewInput = viewController

        return viewController
    }
}
