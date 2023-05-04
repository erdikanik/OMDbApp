//
//  MovieTableViewCell.swift
//  OMDbMovieApp
//
//  Created by Erdi Kanık on 3.05.2023.
//

import Foundation
import UIKit

final class MovieTableViewCell: UITableViewCell {

    private enum Constant {

        static let imageViewEdgeSize = 100.0
        static let fontSize = 14.0
    }

    var model: MovieTableViewModel? {

        didSet {
            guard let model else { return }
            applyModelToViews(model: model)
        }
    }

    private lazy var cellImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: Constant.imageViewEdgeSize).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: Constant.imageViewEdgeSize).isActive = true
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constant.fontSize, weight: .bold)
        label.textColor = .black
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constant.fontSize, weight: .regular)
        label.textColor = .black
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        applyViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Privates

private extension MovieTableViewCell {

    func applyViews() {

        let verticalStack = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        verticalStack.axis = .vertical
        verticalStack.distribution = .fillEqually

        let horizontalStack = UIStackView(arrangedSubviews: [cellImageView, verticalStack])
        horizontalStack.axis = .horizontal
        horizontalStack.distribution = .fill
        cellImageView.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)

        horizontalStack.add(to: contentView)
        horizontalStack.coverToSuperView()
    }

    func applyModelToViews(model: MovieTableViewModel) {

        titleLabel.text = model.title
        descriptionLabel.text = model.description
        imageView?.load(
            url: model.imageUrl,
            imageName: model.imageUrl.components(separatedBy: "/").last ?? "",
            completion: { [weak self] in
            DispatchQueue.main.async {
                if self?.cellImageView.image == nil {
                    self?.setNeedsLayout()
                }
            }
        })
    }
}
