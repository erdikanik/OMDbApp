//
//  DashboardDetailViewController.swift
//  OMDbApp
//
//  Created by Erdi Kanık on 3.05.2023.
//

import UIKit

final class DashboardDetailViewController: UIViewController {

    var viewModel: DashboardDetailViewModelInterface?

    private enum Constant {

        static let imageViewEdgeSize = 300.0
        static let fontSize = 14.0
        static let edgePadding = 20.0
    }

    private lazy var imageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill

        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: Constant.imageViewEdgeSize).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: Constant.imageViewEdgeSize).isActive = true

        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constant.fontSize, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 0

        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constant.fontSize, weight: .regular)
        label.textColor = .black
        label.numberOfLines = 0

        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Detail"
        view.backgroundColor = .white
        applyViews()

        viewModel?.stateChangeHandler = { [weak self] state in
            DispatchQueue.main.async {
                switch(state) {
                case .applyModelToViews(let title, let description, let url):
                    self?.titleLabel.text = title
                    self?.descriptionLabel.text = description
                    self?.imageView.load(url: url, imageName: url.urlComponentsLastItem(), completion: { })
                }
            }
        }

        viewModel?.needToLoadModel()
    }
}

// MARK: Views

private extension DashboardDetailViewController {

    func applyViews() {

        let verticalStackStackView = UIStackView(arrangedSubviews: [imageView, titleLabel, descriptionLabel])
        verticalStackStackView.axis = .vertical
        verticalStackStackView.distribution = .fill
        verticalStackStackView.spacing = Constant.edgePadding

        verticalStackStackView.add(to: view)
        verticalStackStackView.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor,
            constant: Constant.edgePadding
        ).isActive = true
        verticalStackStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}
