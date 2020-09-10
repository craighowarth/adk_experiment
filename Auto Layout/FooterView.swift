//
//  FooterView.swift
//  Sample
//
//  Created by Zev Eisenberg on 9/4/20.
//  Copyright © 2020 Facebook. All rights reserved.
//

import UIKit

final class FooterView: UIView {

  private let dateView: UILabel = {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMM d"
    let displayDate = formatter.string(from: Date())
    let label = UILabel()
    label.attributedText = NSAttributedString(
      string: displayDate,
      attributes: [
        .font: UIFont.systemFont(ofSize: 12),
        .foregroundColor: UIColor.gray
      ])
    return label
  }()

  private let shareButton = UIButton().configure {
    $0.setBackgroundImage(UIImage(named: "NYTShareIcon"), for: .normal)
    $0.setContentHuggingPriority(.required, for: .horizontal)
  }

  private let saveButton = UIButton().configure {
    $0.setBackgroundImage(UIImage(named: "NYTSaveIcon"), for: .normal)
    $0.setContentHuggingPriority(.required, for: .horizontal)
  }

  override init(frame: CGRect) {
    super.init(frame: frame)

    let buttonStackView = UIStackView(arrangedSubviews: [saveButton, shareButton])
    buttonStackView.axis = .horizontal
    buttonStackView.spacing = 5
    buttonStackView.distribution = .fillEqually

    let stackView = UIStackView(arrangedSubviews: [dateView, buttonStackView])
    stackView.axis = .horizontal
    stackView.distribution = .fill

    addSubview(stackView)

    stackView.pinEdgesToSuperView()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
