//
//  SearchSongViewController.swift
//  iOSArchitecturesDemo
//
//  Created by Ke4a on 06.07.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import UIKit

class SearchSongViewController: UIViewController {

    // MARK: - Public Properties

    var searchResults = [ITunesSong]() {
        didSet {
            searchView.collectionView.isHidden = false
            searchView.collectionView.reloadData()
            searchView.searchBar.resignFirstResponder()
        }
    }

    // MARK: - Private Properties

    private var searchView: SearchSongView {
        return self.view as! SearchSongView
    }

    private let presenter: SearchSongViewOutput

    // MARK: - Initialization
    
    init(presenter: SearchSongViewOutput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        self.view = SearchSongView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.searchView.searchBar.delegate = self
        self.searchView.collectionView.register(SearchSongCell.self, forCellWithReuseIdentifier: SearchSongCell.identifier)
        self.searchView.collectionView.dataSource = self
        self.searchView.collectionView.delegate = self
    }
}

//MARK: - UICollectionViewDelegate

extension SearchSongViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let song = searchResults [indexPath.item]
        presenter.viewDidSelectSong(song)
    }
}

//MARK: - UICollectionViewDataSource

extension SearchSongViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        searchResults.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = searchView.collectionView.dequeueReusableCell(withReuseIdentifier: SearchSongCell.identifier, for: indexPath) as? SearchSongCell else { return UICollectionViewCell() }
        
        let song = searchResults[indexPath.row]

        presenter.getCellModel(from: song) { cellModel in
            cell.configure(with: cellModel)
        }

        return cell
    }
}

//MARK: - UISearchBarDelegate

extension SearchSongViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text else {
            searchBar.resignFirstResponder()
            return
        }
        if query.count == 0 {
            searchBar.resignFirstResponder()
            return
        }

        presenter.viewDidSearch(with: query)
    }
}

// MARK: SearchSongViewInput

extension SearchSongViewController: SearchSongViewInput {
    func throbber(show: Bool) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = show
    }

    func showError(error: Error) {
        let alert = UIAlertController(title: "Error", message: "\(error.localizedDescription)", preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(actionOk)
        self.present(alert, animated: true, completion: nil)
    }

    func showNoResults() {
        self.searchView.emptyResultView.isHidden = false
    }

    func hideNoResults() {
        self.searchView.emptyResultView.isHidden = true
    }
}
