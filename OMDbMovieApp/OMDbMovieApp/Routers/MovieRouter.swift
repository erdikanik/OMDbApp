//
//  MovieRouter.swift
//  OMDbApp
//
//  Created by Erdi Kanık on 3.05.2023.
//

import Foundation
import UIKit

protocol MovieRoutable: AnyObject {

    /// Starts routing and set initial view model
    /// - Parameter viewModel: Dashboard view model
    /// - Returns: Navigation controller
    func startRouting(viewModel: DashboardViewModelInterface) -> UINavigationController

    /// Routes to dashboard detail
    /// - Parameter viewModel: Dashboard detail view model
    func routeToDashboardDetail(viewModel: DashboardDetailViewModelInterface)
}

final class MovieRouter {

    private var navigationController: UINavigationController!

    lazy var dashboard: DashboardViewController = {
        let dashboard = DashboardViewController()
        return dashboard
    }()

    lazy var dashboardDetail: DashboardDetailViewController = {
        let dashboardDetail = DashboardDetailViewController()
        return dashboardDetail
    }()
}

// MARK: MovieRoutable

extension MovieRouter: MovieRoutable {

    func startRouting(viewModel: DashboardViewModelInterface) -> UINavigationController {
        dashboard.viewModel = viewModel
        dashboard.router = self
        navigationController = UINavigationController(rootViewController: dashboard)
        return navigationController
    }

    func routeToDashboardDetail(viewModel: DashboardDetailViewModelInterface) {
        dashboardDetail.viewModel = viewModel
        navigationController.pushViewController(dashboardDetail, animated: true)
    }
}
