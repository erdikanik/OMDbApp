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
    }

    var page: Int = 0

    override var parameters: [String : String] {
        var parameters = [Constant.page: String(page)]
        super.parameters.forEach { parameters[$0] = $1 }
        return parameters
    }
}
