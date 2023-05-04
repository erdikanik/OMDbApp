//
//  DashboardViewModel.swift
//  OMDbApp
//
//  Created by Erdi Kanık on 3.05.2023.
//

import Foundation

enum DashboardViewModelState {

    case initialMovies([Movie], [Movie])
    case tableViewMoviesFetched([Movie])
    case error(String)
}

protocol DashboardViewModelInterface {

    /// State change handler of dashboard view model
    var stateChangeHandler: ((DashboardViewModelState) -> Void)? { get set }

    /// Fetches initial movies for table view and collection view
    func fetchInitialMovies()

    /// Increase page count and fetches new pages
    func needsNewPage()


    /// Retrieve movies by search parameter
    /// - Parameter searchKey: Search key
    func searchMovies(searchKey: String)
}

final class DashboardViewModel {

    private enum Constant {

        static let initialTableViewSearchKey = "Star"
        static let collectionViewDefaultSearchKey = "Comedy"
        static let pageDelayTime = 0.25
        static let searchDelayTime = 0.5
    }

    let networkManager: NetworkManagerProtocol

    var stateChangeHandler: ((DashboardViewModelState) -> Void)?

    private var currentTableViewPage = 1
    private var currentCollectionViewPage = 1
    private var currentTableViewSearchKeyword = Constant.initialTableViewSearchKey

    private var tableViewMovies: [Movie] = []
    private var collectionViewMovies: [Movie] = []
    private var lockedTableFetches = true
    private var requestedSearchArray: [String] = []
    private var timer: Timer?
    private var currentUrlSessionTask: URLSessionTask?

    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
}

extension DashboardViewModel: DashboardViewModelInterface {

    func fetchInitialMovies() {
        callMovieServicesForTableViewAndCollectionView()
    }

    func needsNewPage() {
        guard !lockedTableFetches else { return }
        lockedTableFetches = true
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Constant.pageDelayTime) {
            _ = self.callMovieService(
                searchKey: self.currentTableViewSearchKeyword,
                page: self.currentTableViewPage + 1
            ) { [weak self] response, error in

                self?.lockedTableFetches = false
                guard error == nil else {
                    self?.stateChangeHandler?(.error(error?.localizedDescription ?? ""))
                    return
                }

                if !(response?.searchResults.isEmpty ?? true) {
                    self?.currentTableViewPage += 1
                    self?.tableViewMovies.append(contentsOf: response?.searchResults ?? [])
                    self?.stateChangeHandler?(.tableViewMoviesFetched(self?.tableViewMovies ?? []))
                }
            }
        }
    }

    func searchMovies(searchKey: String) {

        guard !searchKey.isEmpty else { return }
        requestedSearchArray.append(searchKey)

        if self.timer == nil {
            self.timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [weak self] timer in
                guard !(self?.requestedSearchArray.isEmpty ?? false) else {
                    self?.timer?.invalidate()
                    self?.timer = nil
                    return
                }

                self?.currentUrlSessionTask?.cancel()
                if let lastKey = self?.requestedSearchArray.last {
                    self?.callMovieService(searchKey: lastKey)
                }
                self?.requestedSearchArray.removeAll()
            }
        }
    }
}

// MARK: Service calls

private extension DashboardViewModel {

    func callMovieService(searchKey: String) {
        currentUrlSessionTask =  callMovieService(searchKey: searchKey, page: 1) { [weak self] response, error in
            self?.currentTableViewSearchKeyword = searchKey
            self?.currentTableViewPage = 1
            guard error  == nil else {
                self?.stateChangeHandler?(.error(error?.localizedDescription ?? ""))
                return
            }

            if !(response?.searchResults.isEmpty ?? true) {
                self?.tableViewMovies = response?.searchResults ?? []
                self?.stateChangeHandler?(.tableViewMoviesFetched(self?.tableViewMovies ?? []))
            }
        }
    }

    func callMovieServicesForTableViewAndCollectionView() {
        let group = DispatchGroup()

        group.enter()
        _ = callMovieService(
            searchKey: Constant.initialTableViewSearchKey,
            page: currentTableViewPage
        ) { [weak self] response, error in

            if let results = response?.searchResults {
                self?.tableViewMovies.append(contentsOf: results)
            }
            group.leave()
        }

        group.enter()
        _ = callMovieService(
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
            self.lockedTableFetches = false
        }
    }

    func callMovieService(searchKey: String, page: Int, completion: @escaping (MovieResponse?, Error?)->()) -> URLSessionTask? {
        let movieRequest = MovieRequest()
        movieRequest.page = page
        movieRequest.searchKey = searchKey
        return networkManager.performRequest(request: movieRequest) {(result: Result<MovieResponse>) in
            switch result {
            case .error(let serviceError):
                completion(nil, serviceError)
            case .success(let response):
                completion(response, nil)
            }
        }
    }
}
