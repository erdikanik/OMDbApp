//
//  DashboardViewModel.swift
//  OMDbApp
//
//  Created by Erdi Kanık on 3.05.2023.
//

import Foundation

enum DashboardViewModelState {

    case initialMovies([Movie], [Movie])
    case error(String)
}

protocol DashboardViewModelInterface {

    /// State change handler of dashboard view model
    var stateChangeHandler: ((DashboardViewModelState) -> Void)? { get set }

    /// Fetches initial movies for table view and collection view
    func fetchInitialMovies()
}

final class DashboardViewModel {

    private enum Constant {

        static let initialTableViewSearchKey = "Star"
        static let collectionViewDefaultSearchKey = "Comedy"
    }

    let networkManager: NetworkManagerProtocol

    var stateChangeHandler: ((DashboardViewModelState) -> Void)?

    private var currentTableViewPage = 1
    private var currentCollectionViewPage = 1

    private var tableViewMovies: [Movie] = []
    private var collectionViewMovies: [Movie] = []

    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
}

extension DashboardViewModel: DashboardViewModelInterface {

    func fetchInitialMovies() {
        callMovieServicesForTableViewAndCollectionView()
    }
}

// MARK: Service calls

private extension DashboardViewModel {

    func callMovieServicesForTableViewAndCollectionView() {
        let group = DispatchGroup()

        group.enter()
        callMovieService(
            searchKey: Constant.initialTableViewSearchKey,
            page: currentTableViewPage
        ) { [weak self] response, error in

            if let results = response?.searchResults {
                self?.tableViewMovies.append(contentsOf: results)
            }
            group.leave()
        }

        group.enter()
        callMovieService(
            searchKey: Constant.collectionViewDefaultSearchKey,
            page: currentCollectionViewPage
        ) { [weak self] response, error in

            if let results = response?.searchResults {
                self?.collectionViewMovies.append(contentsOf: results)
            }
            group.leave()
        }

        group.notify(queue: .main) {
            self.stateChangeHandler?(.initialMovies(self.tableViewMovies, self.collectionViewMovies))
        }
    }

    func callMovieService(searchKey: String, page: Int, completion: @escaping (MovieResponse?, Error?)->()) {
        let movieRequest = MovieRequest()
        movieRequest.page = page
        movieRequest.searchKey = searchKey
        networkManager.performRequest(request: movieRequest) {(result: Result<MovieResponse>) in
            switch result {
            case .error(let serviceError):
                completion(nil, serviceError)
            case .success(let response):
                completion(response, nil)
            }
        }
    }
}
