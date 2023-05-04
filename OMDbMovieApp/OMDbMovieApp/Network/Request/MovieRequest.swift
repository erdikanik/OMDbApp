//
//  MovieRequest.swift
//  OMDbMovieApp
//
//  Created by Erdi Kanık on 3.05.2023.
//

import Foundation

final class MovieRequest: BaseRequest {

    private enum Constant {

        static let page = "page"
        static let searchKey = "s"
    }

    var page: Int = 0
    var searchKey = ""

    override var parameters: [String : String] {
        var parameters = [
            Constant.page: String(page),
            Constant.searchKey: String(searchKey)
        ]
        super.parameters.forEach { parameters[$0] = $1 }
        return parameters
    }
}
