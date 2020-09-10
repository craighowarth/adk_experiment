//
//  LargeImageCell.swift
//  Sample
//
//  Created by Su, Wei-Lun on 9/8/20.
//  Copyright © 2020 Facebook. All rights reserved.
//

import UIKit

final class LargeImageCell: BottomSeparatorCell {

  private let headlineLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  private let summaryLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  private let kickerLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  private let creditLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  private let footerLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  private let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()

  private var imageAspectConstraint = NSLayoutConstraint()

  override init(frame: CGRect) {
    super.init(frame: frame)

    let mainStack = UIStackView(axis: .vertical, spacing: 10, arrangedSubviews: [
      UIStackView(axis: .vertical, spacing: 2, arrangedSubviews: [
        imageView,
        creditLabel
      ]),
      UIStackView(axis: .vertical, spacing: 2, arrangedSubviews: [
        kickerLabel,
        headlineLabel
      ]),
      summaryLabel,
      footerLabel
    ])
    contentView.addSubview(mainStack)
    mainStack.pinEdgesToSuperView(lowerBottomAndTrailingPriorities: true)
    mainStack.isLayoutMarginsRelativeArrangement = true
    mainStack.layoutMargins = UIEdgeInsets(all: 10)
  }

  func set(headline: String, summary: String, kicker: String, credit: String, crop: Crop) {
    headlineLabel.attributedText = NSAttributedString(
      string: headline,
      attributes: [
        NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18),
        NSAttributedString.Key.foregroundColor: UIColor.black
      ])

    summaryLabel.attributedText = NSAttributedString(
      string: summary,
      attributes: [
        NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14),
        NSAttributedString.Key.foregroundColor: UIColor.darkGray
      ])
    imageView.image = UIImage(named: crop.imageFilename)
    imageAspectConstraint.isActive = false
    imageAspectConstraint = imageView.heightAnchor.constraint(
      equalTo: imageView.widthAnchor,
      multiplier: crop.size.height / crop.size.width
    )
    imageAspectConstraint.isActive = true

    creditLabel.attributedText = NSAttributedString(
      string: credit,
      attributes: [
        NSAttributedString.Key.font: UIFont.systemFont(ofSize: 9),
        NSAttributedString.Key.foregroundColor: UIColor.lightGray
      ])
    creditLabel.isHidden = credit.isEmpty

    kickerLabel.attributedText = NSAttributedString(
      string: kicker,
      attributes: [
        NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12),
        NSAttributedString.Key.foregroundColor: UIColor.black
      ])
    kickerLabel.isHidden = kicker.isEmpty
  }
}
