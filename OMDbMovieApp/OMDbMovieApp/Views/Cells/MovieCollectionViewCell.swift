//
//  MovieCollectionViewCell.swift
//  OMDbMovieApp
//
//  Created by Erdi Kanık on 5.05.2023.
//

import UIKit

final class MovieCollectionViewCell: UICollectionViewCell {

    private lazy var collectionViewCellImageView = {
        let imageView = UIImageView()
        return imageView
    }()

    var imageUrl: String? {

        didSet {
            if let imageUrl {
                loadImage(url: imageUrl)
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .cyan
        loadViewsForCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Views

private extension MovieCollectionViewCell {

    func loadViewsForCell() {
        collectionViewCellImageView.add(to: contentView)
        collectionViewCellImageView.coverToSuperView()
    }

    func loadImage(url: String) {
        collectionViewCellImageView.load(url: url, imageName: url.urlComponentsLastItem()) { [weak self] in
            self?.setNeedsLayout()
        }
    }
}
