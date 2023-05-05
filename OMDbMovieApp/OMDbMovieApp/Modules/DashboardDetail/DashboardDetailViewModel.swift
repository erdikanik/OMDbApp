//
//  DashboardDetailViewModel.swift
//  OMDbMovieApp
//
//  Created by Erdi Kanık on 5.05.2023.
//

import Foundation

enum DashboardViewDetailModelState {

    // title, description, url
    case applyModelToViews(String, String, String)
}

protocol DashboardDetailViewModelInterface {

    /// State change handler of dashboard detail view model
    var stateChangeHandler: ((DashboardViewDetailModelState) -> Void)? { get set }

    /// Shoul be called when it is needed to load model
    func needToLoadModel()
}

final class DashboardDetailViewModel {

    var stateChangeHandler: ((DashboardViewDetailModelState) -> Void)?

    let movie: Movie

    init(movie: Movie) {
        self.movie = movie
    }
}

// MARK: DashboardDetailViewModelInterface

extension DashboardDetailViewModel: DashboardDetailViewModelInterface {

    func needToLoadModel() {
        stateChangeHandler?(.applyModelToViews(movie.title, movie.type + " - " + movie.year, movie.poster))
    }
}
