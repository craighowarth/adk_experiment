//
//  LargeImageCell.swift
//  Sample
//
//  Created by Su, Wei-Lun on 9/8/20.
//  Copyright © 2020 Facebook. All rights reserved.
//

import UIKit

final class LargeImageCell: BottomSeparatorCell {

  let headlineLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  let summaryLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  let kickerLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  let creditLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  let footerLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  private lazy var imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()

  override init (frame: CGRect) {
    super.init(frame: frame)
    [headlineLabel,
     summaryLabel,
     kickerLabel,
     creditLabel,
     footerLabel,
     imageView].forEach { contentView.addSubview($0) }

    NSLayoutConstraint.activate([
      imageView.heightAnchor.constraint(equalToConstant: 160.0),
      imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20.0),
      imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10.0),
      imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10.0),

      headlineLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10.0),
      headlineLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10.0),
      headlineLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10.0),

      summaryLabel.topAnchor.constraint(equalTo: headlineLabel.bottomAnchor, constant: 10.0),
      summaryLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10.0),
      summaryLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10.0),
      summaryLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10.0)])
  }

  func set(headline: String, summary: String, image: String) {
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
    imageView.image = UIImage(named: image)
  }
}
