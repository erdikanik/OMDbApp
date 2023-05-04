//
//  DashboardViewController.swift
//  OMDbApp
//
//  Created by Erdi Kanık on 3.05.2023.
//

import Foundation
import UIKit

final class DashboardViewController: UIViewController {

    private enum Constant {

        static let collectionViewHeight = 250.0
        static let tableViewCellHeight = 100.0
    }

    var viewModel: DashboardViewModelInterface?

    private var tableViewMovies: [Movie] = []
    private var collectionViewMovies: [Movie] = []

    private let searchController = UISearchController(searchResultsController: nil)

    private let collectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        collectionView.backgroundColor = .blue
        collectionView.heightAnchor.constraint(equalToConstant: Constant.collectionViewHeight).isActive = true

        return collectionView
    }()

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .green
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Movies"
        applyStyle()
        applySearchController()
        applyViews()

        viewModel?.stateChangeHandler = { [weak self] state in
            switch(state) {
            case .initialMovies(let tableViewMovies, let collectionViewMovies):
                self?.tableViewMovies = tableViewMovies
                self?.collectionViewMovies = collectionViewMovies
                self?.tableView.reloadData()
            case .error(let error):
                // TODO: Will be implemented
                break
            }
        }

        viewModel?.fetchInitialMovies()
    }
}

// MARK: Views

private extension DashboardViewController {

    func applyStyle() {
        view.backgroundColor = .white
    }

    func applyViews() {
        tableView.dataSource = self
        tableView.delegate = self

        let stackView = UIStackView(arrangedSubviews: [tableView, collectionView])
        stackView.axis = .vertical
        stackView.distribution = .fill

        stackView.add(to: view)
        stackView.coverToSuperViewSafeArea()
    }

    func applySearchController() {

        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Movies"
        navigationItem.searchController = searchController
        definesPresentationContext = true

        searchController.searchBar.delegate = self
    }
}

// MARK: UISearchResultsUpdating

extension DashboardViewController: UISearchResultsUpdating {

  func updateSearchResults(for searchController: UISearchController) {
      // TODO: Will be implemented
  }
}

// MARK: UISearchBarDelegate

extension DashboardViewController: UISearchBarDelegate {

  func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
      // TODO: Will be implemented
  }
}

// MARK: UITableViewDataSource

extension DashboardViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableViewMovies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MovieTableViewCell(style: .default, reuseIdentifier: MovieTableViewCell.reuseIdentifier())
        let model = tableViewMovies[indexPath.row]
        cell.model = MovieTableViewModel(model: model)

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Constant.tableViewCellHeight
    }
}

// MARK: UITableViewDelegate

extension DashboardViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        // TODO: Will be implemented
    }
}
