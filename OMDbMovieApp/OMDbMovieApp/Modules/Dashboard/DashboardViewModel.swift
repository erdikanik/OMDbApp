//
//  DashboardViewModel.swift
//  OMDbApp
//
//  Created by Erdi Kanık on 3.05.2023.
//

import Foundation

protocol DashboardViewModelInterface {

    // TODO: Will be implemented
}

final class DashboardViewModel: DashboardViewModelInterface {

    private enum Constant {

        static let initialTableViewSearchKey = "Star"
        static let collectionViewDefaultSearchKey = "Comedy"
    }

    let networkManager: NetworkManagerProtocol

    private var currentTableViewPage = 1
    private var currentCollectionViewPage = 1

    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
}

// MARK: Service calls

private extension DashboardViewModel {

    func callMovieServicesForTableViewAndCollectionView() {
        let group = DispatchGroup()

        group.enter()
        callMovieService(searchKey: Constant.initialTableViewSearchKey, page: currentTableViewPage) { response, error in

            group.leave()
        }

        group.enter()
        callMovieService(searchKey: Constant.collectionViewDefaultSearchKey, page: currentCollectionViewPage) { response, error in
            group.leave()
        }

        group.notify(queue: .main) {
            // TODO: Will be implemented
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
