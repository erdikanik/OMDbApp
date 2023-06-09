//
//  NetworkManager.swift
//  OMDbMovieApp
//
//  Created by Erdi Kanık on 3.05.2023.
//

import Foundation

enum Result<T> {
    case success(T)
    case error(Error)
}

protocol NetworkManagerProtocol {

    func performRequest<T: Decodable>(request: BaseRequest, completion: @escaping (Result<T>) -> Void) -> URLSessionTask?
}

final class NetworkManager: NetworkManagerProtocol {

    func performRequest<T: Decodable>(request: BaseRequest, completion: @escaping (Result<T>) -> Void) -> URLSessionTask? {
        guard let networkRequest = request.asURLRequest() else { return nil }

        let task = URLSession.shared.dataTask(with: networkRequest) { (data, _, error) in
            guard let data = data else {
                completion(Result.error(error ?? NSError()))
                return
            }
            // print(String(data: data, encoding: .utf8)!)

            let decoder = JSONDecoder()

            do {
                let responseModel = try decoder.decode(T.self, from: data)
                completion(Result.success(responseModel))
            } catch {
                completion(Result.error(error))
            }
        }

        task.resume()
        return task
    }
}
