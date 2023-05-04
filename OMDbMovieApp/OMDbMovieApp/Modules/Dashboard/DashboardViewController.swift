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
        static let loadingViewBackgroundOpacity = 0.5
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
        return tableView
    }()

    /// Can be move key screen window
    private let loadingView: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(Constant.loadingViewBackgroundOpacity)
        let indicatorView = UIActivityIndicatorView(style: .large)
        indicatorView.color = .white
        indicatorView.add(to: view)
        indicatorView.addToMiddle()
        indicatorView.startAnimating()
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Movies"
        applyStyle()
        applySearchController()
        applyViews()

        viewModel?.stateChangeHandler = { [weak self] state in
            DispatchQueue.main.async {
                switch(state) {
                case .initialMovies(let tableViewMovies, let collectionViewMovies):
                    self?.tableViewMovies = tableViewMovies
                    self?.collectionViewMovies = collectionViewMovies
                    self?.tableView.reloadData()
                    self?.removeLoadingView()
                case .tableViewMoviesFetched(let movies):
                    self?.tableViewMovies = movies
                    self?.tableView.reloadData()
                case .error(let error):
                    // TODO: Will be implemented
                    break
                }
            }
        }

        showLoadingView()
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
    }

    func showLoadingView() {
        loadingView.add(to: view)
        loadingView.coverToSuperView()
    }

    func removeLoadingView() {
        loadingView.removeFromSuperview()
    }
}

// MARK: ScrollView

extension DashboardViewController {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if tableView.contentOffset.y >= (tableView.contentSize.height - tableView.frame.size.height) {
            self.viewModel?.needsNewPage()
        }
    }
}

// MARK: UISearchResultsUpdating

extension DashboardViewController: UISearchResultsUpdating {

  func updateSearchResults(for searchController: UISearchController) {
      guard let text = searchController.searchBar.text else { return }
      viewModel?.searchMovies(searchKey: text)
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
