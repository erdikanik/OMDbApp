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
    }

    var viewModel: DashboardViewModelInterface?

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

        let stackView = UIStackView(arrangedSubviews: [tableView, collectionView])
        stackView.axis = .vertical
        stackView.distribution = .fill

        stackView.add(to: view)
        stackView.coverToSuperView()
    }
}

// MARK: Views

private extension DashboardViewController {

    func applyStyle() {
        view.backgroundColor = .white
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
        0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

// MARK: UITableViewDelegate

extension DashboardViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        // TODO: Will be implemented
    }
}
