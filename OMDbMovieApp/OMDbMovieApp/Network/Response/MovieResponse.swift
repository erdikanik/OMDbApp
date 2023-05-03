//
//  MovieResponse.swift
//  OMDbMovieApp
//
//  Created by Erdi Kanık on 3.05.2023.
//

import Foundation

final class MovieResponse: Decodable {

    private enum CodingKeys: String, CodingKey {

        case searchResults = "Search"
    }

    let searchResults: [Movie]
}
