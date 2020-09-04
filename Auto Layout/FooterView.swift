//
//  FooterView.swift
//  Sample
//
//  Created by Zev Eisenberg on 9/4/20.
//  Copyright © 2020 Facebook. All rights reserved.
//

import UIKit

final class FooterView: UIView {

  private lazy var dateView: UILabel = {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMM d"
    let displayDate = formatter.string(from: Date())
    let label = UILabel()
    label.attributedText = NSAttributedString(
      string: displayDate,
      attributes: [
        NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12),
        NSAttributedString.Key.foregroundColor: UIColor.gray
      ])
    return label
  }()

  private lazy var shareButton: UIButton = {
    let button = UIButton()
    button.setBackgroundImage(UIImage(named: "NYTShareIcon"), for: .normal)
    button.setContentHuggingPriority(.required, for: .horizontal)
    return button
  }()

  private lazy var saveButton: UIButton = {
    let button = UIButton()
    button.setBackgroundImage(UIImage(named: "NYTSaveIcon"), for: .normal)
    button.setContentHuggingPriority(.required, for: .horizontal)
    return button
  }()

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
