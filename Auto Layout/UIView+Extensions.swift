//
//  UIView+Extensions.swift
//  Sample
//
//  Created by Zev Eisenberg on 9/4/20.
//  Copyright © 2020 Facebook. All rights reserved.
//

import UIKit

extension UIView {
  func pinEdgesToSuperView() {
    guard let view = superview else { return }
    pinEdges(to: view)
  }

  func pinEdges(to view: UIView) {
    translatesAutoresizingMaskIntoConstraints = false
    topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
    bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
    trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
  }
}

extension UIStackView {
  func addArrangedSubviews(_ subviews: [UIView]) {
    subviews.forEach(addArrangedSubview(_:))
  }
}
