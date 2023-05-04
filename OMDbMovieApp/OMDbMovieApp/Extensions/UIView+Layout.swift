//
//  UIView+Layout.swift
//  OMDbMovieApp
//
//  Created by Erdi Kanık on 3.05.2023.
//

import UIKit

extension UIView {

    func add(to superView:UIView) {

        superView.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
    }

    func coverToSuperView(edgeInsents: UIEdgeInsets =  UIEdgeInsets.zero) {

        guard let superview = superview else {
            return
        }

        leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: edgeInsents.left).isActive = true
        trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -edgeInsents.right).isActive = true
        topAnchor.constraint(equalTo: superview.topAnchor, constant: edgeInsents.top).isActive = true
        bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: edgeInsents.bottom).isActive = true
    }

    func coverToSuperViewSafeArea(edgeInsents: UIEdgeInsets =  UIEdgeInsets.zero) {

        guard let superview = superview else {
            return
        }

        leadingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.leadingAnchor, constant: edgeInsents.left).isActive = true
        trailingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.trailingAnchor, constant: -edgeInsents.right).isActive = true
        topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor, constant: edgeInsents.top).isActive = true
        bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor, constant: edgeInsents.bottom).isActive = true
    }
}
