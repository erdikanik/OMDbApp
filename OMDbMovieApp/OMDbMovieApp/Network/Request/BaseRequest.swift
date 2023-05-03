//
//  BaseRequest.swift
//  OMDbMovieApp
//
//  Created by Erdi Kanık on 3.05.2023.
//

import Foundation

class BaseRequest {

    private enum Constant {

        static let basePath = "https://omdbapi.com/?s=Star&apikey=2e9eed30"
    }

    private enum MappingKeys {
        static let apiKey = "apikey"
    }

    private enum MappingValues {
        static let apiKey = "2e9eed30"
    }

    var path: String {
        ""
    }

    var parameters: [String: String] {
        return [MappingKeys.apiKey: MappingValues.apiKey]
    }

    private func urlParameters() -> String {
        let urlMap = "?"
        return urlMap + parameters.map { $0.key + "=" + $0.value + "&" }.joined()
    }

    func asURLRequest() -> URLRequest? {
        guard let url = URL(string: Constant.basePath.appending(path).appending(urlParameters())) else {
            return nil
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"

        return urlRequest
    }
}
