//
//  DashboardDetailViewModel.swift
//  OMDbMovieApp
//
//  Created by Erdi Kanık on 5.05.2023.
//

import Foundation

protocol DashboardDetailViewModelInterface { }

final class DashboardDetailViewModel {

    let movie: Movie

    init(movie: Movie) {
        self.movie = movie
    }
}

// MARK: DashboardDetailViewModelInterface

extension DashboardDetailViewModel: DashboardDetailViewModelInterface { }
