//
//  ThumbnailCell.swift
//  Sample
//
//  Created by Zev Eisenberg on 9/4/20.
//  Copyright © 2020 Facebook. All rights reserved.
//

import UIKit

final class ThumbnailCell: UICollectionViewCell, Reusable {

  private lazy var textView: UITextView = {
    let textView = UITextView()
    textView.isUserInteractionEnabled = false
    textView.isScrollEnabled = false
    textView.setContentCompressionResistancePriority(.required, for: .vertical)
    return textView
  }()

  private lazy var imageView: UIImageView = {
    let image = UIImage(named: "thumbnail.jpg")
    let imageView = UIImageView(image: image)
    return imageView
  }()

  private let footerView = FooterView()

  private let thumbnailSize = CGSize(width: 75.0, height: 75.0)

  override init(frame: CGRect) {
    super.init(frame: frame)

    backgroundColor = .white

    let stackView = UIStackView(arrangedSubviews: [textView, footerView])
    stackView.axis = .vertical
    stackView.distribution = .fill
    stackView.spacing = 5

    contentView.addSubview(stackView)
    contentView.addSubview(imageView)

    stackView.pinEdges(to: contentView)
    imageView.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: textView.textContainerInset.top),
      imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -(textView.textContainer.lineFragmentPadding + textView.textContainerInset.right)),
      imageView.widthAnchor.constraint(equalToConstant: thumbnailSize.width),
      imageView.heightAnchor.constraint(equalToConstant: thumbnailSize.height)
    ])
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {

    let margin: CGFloat = 5
    let rect = CGRect(
      x: targetSize.width - thumbnailSize.width - margin - textView.textContainerInset.left - textView.textContainerInset.right,
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
        NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18),
        NSAttributedString.Key.foregroundColor: UIColor.black
      ]
    )

    let summary = NSAttributedString(
      string: summary,
      attributes: [
        NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14),
        NSAttributedString.Key.foregroundColor: UIColor.darkGray
      ]
    )

    string.append(summary)

    textView.attributedText = string
  }
}
