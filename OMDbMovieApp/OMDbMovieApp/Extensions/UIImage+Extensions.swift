//
//  UIImage+Extensions.swift
//  OMDbMovieApp
//
//  Created by Erdi Kanık on 4.05.2023.
//

import UIKit

extension UIImageView {

    func load(url: String?, imageName: String, completion: @escaping ()->()) {
        DispatchQueue.main.async {
            self.backgroundColor = .white

            let imageData = FileUtil.getFile(by: imageName)

            guard imageData == nil else {
                DispatchQueue.main.async {
                    self.image = UIImage(data: imageData ?? Data())
                    completion()
                }
                return
            }

            guard let url = url, let imageUrl = URL(string: url) else {
                completion()
                return
            }

            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: imageUrl) {
                    if let image = UIImage(data: data) {
                        FileUtil.saveFile(by: imageName, data: data)
                        DispatchQueue.main.async {
                            self?.image = image
                            completion()
                        }
                    }
                }
            }
        }
    }
}
