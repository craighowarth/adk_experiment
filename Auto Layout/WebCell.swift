//
//  WebCell.swift
//  Sample
//
//  Created by Zev Eisenberg on 9/10/20.
//  Copyright © 2020 The New York Times. All rights reserved.
//

import UIKit
import WebKit

final class WebCell: BottomSeparatorCell {

  private let disclaimerLabel = UILabel().configure {
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.alignment = .center
    $0.attributedText = NSAttributedString(
      string: "ADVERTISEMENT",
      attributes: [
        .paragraphStyle: paragraphStyle,
        .font: UIFont.systemFont(ofSize: 9.0),
        .foregroundColor: UIColor.lightGray
      ])
  }

  private let webView = WKWebView().configure {
    $0.scrollView.isScrollEnabled = false
  }

  lazy var webViewHeightConstraint = webView.heightAnchor.constraint(equalToConstant: 0).activated()

  override init(frame: CGRect) {
    super.init(frame: frame)

    let stack = UIStackView(axis: .vertical, spacing: 10, arrangedSubviews: [
      disclaimerLabel,
      webView,
    ])
    stack.isLayoutMarginsRelativeArrangement = true
    stack.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
    contentView.addSubview(stack)
    stack.pinEdgesToSuperView(lowerBottomAndTrailingPriorities: true)
  }

  func set(url: URL, height: CGFloat) {
    webView.load(URLRequest(url: url))
    webViewHeightConstraint.constant = height
  }

}
