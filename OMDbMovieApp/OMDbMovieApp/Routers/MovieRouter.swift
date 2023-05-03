//
//  MovieRouter.swift
//  OMDbApp
//
//  Created by Erdi Kanık on 3.05.2023.
//

import Foundation
import UIKit

protocol MovieRoutable {

    func startRouting(viewModel: DashboardViewModelInterface) -> UINavigationController
}

final class MovieRouter {

    private var navigationController: UINavigationController!

    lazy var dashboard: DashboardViewController = {
        let dashboard = DashboardViewController()
        return dashboard
    }();
}

// MARK: MovieRoutable

extension MovieRouter: MovieRoutable {

    func startRouting(viewModel: DashboardViewModelInterface) -> UINavigationController {
        dashboard.viewModel = viewModel
        navigationController = UINavigationController(rootViewController: dashboard)
        return navigationController
    }
}
