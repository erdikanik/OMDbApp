//
//  UIView+Additions.swift
//  OMDbMovieApp
//
//  Created by Erdi Kanık on 3.05.2023.
//

import UIKit

extension UIView {

    static func reuseIdentifier() -> String {

        return String(describing: self)
    }
}
