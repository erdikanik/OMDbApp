//
//  MovieTableViewModel.swift
//  OMDbMovieApp
//
//  Created by Erdi Kanık on 3.05.2023.
//

import Foundation

struct MovieTableViewModel {

    private(set) var imageUrl: String
    private(set) var title: String
    private(set) var description: String

    init(model: Movie) {
        self.imageUrl = model.poster
        self.title = model.title
        self.description = model.type + " - " + model.year
    }
}
