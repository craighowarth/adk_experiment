//
//  BottomSeparatorCell.swift
//  Sample
//
//  Created by Zev Eisenberg on 9/4/20.
//  Copyright © 2020 Facebook. All rights reserved.
//

import UIKit

class BottomSeparatorCell: UICollectionViewCell, Reusable {

  override init(frame: CGRect) {
    super.init(frame: frame)

    let separator = UIView()
    contentView.addSubview(separator)
    separator.backgroundColor = .separator
    separator.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      separator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      separator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      separator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      separator.heightAnchor.constraint(equalToConstant: 1 / UIScreen.main.scale)
    ])
  }

  @available(*, unavailable) required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}
