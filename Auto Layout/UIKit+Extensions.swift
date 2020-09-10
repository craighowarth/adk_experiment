//
//  UIKit+Extensions.swift
//  Sample
//
//  Created by Zev Eisenberg on 9/4/20.
//  Copyright © 2020 Facebook. All rights reserved.
//

import UIKit

extension UIView {
  func pinEdgesToSuperView(lowerBottomAndTrailingPriorities: Bool = false) {
    guard let view = superview else { fatalError("No superview to pin to") }
    pinEdges(to: view, lowerBottomAndTrailingPriorities: lowerBottomAndTrailingPriorities)
  }

  func pinEdges(to view: UIView, lowerBottomAndTrailingPriorities: Bool = false) {
    translatesAutoresizingMaskIntoConstraints = false
    let amountToSubtract: Float = lowerBottomAndTrailingPriorities ? 1 : 0
    NSLayoutConstraint.activate([
      topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
      bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        .withPriority(.required - amountToSubtract),
      leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
      trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
        .withPriority(.required - amountToSubtract),
    ])
  }
}

extension UIStackView {
  func addArrangedSubviews(_ subviews: [UIView]) {
    subviews.forEach(addArrangedSubview(_:))
  }
  convenience init(axis: NSLayoutConstraint.Axis, spacing: CGFloat? = nil, arrangedSubviews: [UIView] = []) {
    self.init()
    self.axis = axis
    if let spacing = spacing {
      self.spacing = spacing
    }
    addArrangedSubviews(arrangedSubviews)
  }
}

extension NSLayoutConstraint {
  func withPriority(_ priority: UILayoutPriority) -> Self {
    self.priority = priority
    return self
  }

  func activated() -> Self {
    isActive = true
    return self
  }
}

extension UIEdgeInsets {
  init(all length: CGFloat) {
    self.init(top: length, left: length, bottom: length, right: length)
  }
}
