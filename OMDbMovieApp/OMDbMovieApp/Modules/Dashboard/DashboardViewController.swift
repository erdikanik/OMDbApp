//
//  DashboardViewController.swift
//  OMDbApp
//
//  Created by Erdi Kanık on 3.05.2023.
//

import Foundation
import UIKit

final class DashboardViewController: UIViewController {

    var viewModel: DashboardViewModelInterface?

    private let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Movies"
        applyStyle()
        applySearchController()
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
