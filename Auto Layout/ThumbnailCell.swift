//
//  ThumbnailCell.swift
//  Sample
//
//  Created by Zev Eisenberg on 9/4/20.
//  Copyright © 2020 Facebook. All rights reserved.
//

import UIKit

final class ThumbnailCell: BottomSeparatorCell {

  private lazy var textView: UITextView = {
    let textView = UITextView()
    textView.isUserInteractionEnabled = false
    textView.isScrollEnabled = false
    textView.setContentCompressionResistancePriority(.required, for: .vertical)
    textView.textContainerInset = .zero
    textView.textContainer.lineFragmentPadding = 0
    return textView
  }()

  private lazy var imageView: UIImageView = {
    let image = UIImage(named: "thumbnail.jpg")
    let imageView = UIImageView(image: image)
    return imageView
  }()

  private let footerView = FooterView()

  private let thumbnailSize = CGSize(width: 75.0, height: 75.0)

  private let stackView = UIStackView()

  override init(frame: CGRect) {
    super.init(frame: frame)

    backgroundColor = .white

    stackView.addArrangedSubviews([textView, footerView])
    stackView.axis = .vertical
    stackView.distribution = .fill
    stackView.spacing = 5
    stackView.isLayoutMarginsRelativeArrangement = true
    stackView.layoutMargins = UIEdgeInsets(top: 0, left: .inset, bottom: 0, right: .inset)

    contentView.addSubview(stackView)
    contentView.addSubview(imageView)

    stackView.pinEdges(to: contentView)
    imageView.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: textView.textContainerInset.top),
      imageView.trailingAnchor.constraint(equalTo: textView.trailingAnchor),
      imageView.widthAnchor.constraint(equalToConstant: thumbnailSize.width),
      imageView.heightAnchor.constraint(equalToConstant: thumbnailSize.height)
    ])
  }

  override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {

    let margin: CGFloat = 5
    let rect = CGRect(
      x: targetSize.width - stackView.layoutMargins.left - stackView.layoutMargins.right - thumbnailSize.width - margin - textView.textContainerInset.left - textView.textContainerInset.right,
      y: 0,
      width: thumbnailSize.width + margin + textView.textContainerInset.left + textView.textContainerInset.right,
      height: thumbnailSize.height + margin
    )
    let exclusionPath = UIBezierPath(rect: rect)
    textView.textContainer.exclusionPaths = [exclusionPath]

    let size = super.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: horizontalFittingPriority, verticalFittingPriority: verticalFittingPriority)

    return size
  }

  func set(headline: String, summary: String) {
    let string = NSMutableAttributedString(
      string: headline + "\n",
      attributes: [
        .font: UIFont.boldSystemFont(ofSize: 18),
        .foregroundColor: UIColor.black
      ]
    )

    let summary = NSAttributedString(
      string: summary,
      attributes: [
        .font: UIFont.systemFont(ofSize: 14),
        .foregroundColor: UIColor.darkGray
      ]
    )

    string.append(summary)

    textView.attributedText = string
  }
}
