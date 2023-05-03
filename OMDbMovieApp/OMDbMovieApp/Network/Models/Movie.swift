//
//  Movie.swift
//  OMDbMovieApp
//
//  Created by Erdi Kanık on 3.05.2023.
//

import Foundation

struct Movie: Decodable {

    private enum CodingKeys: String, CodingKey {

        case title = "Title"
        case year = "Year"
        case imdbId = "imdbID"
        case type = "Type"
        case poster = "Poster"
    }

    let title: String
    let year: String
    let imdbId: String
    let type: String
    let poster: String
}
