//
//  CollectionViewController.swift
//  Sample
//
//  Created by Jonathan Lazar on 9/3/20.
//  Copyright © 2020 Facebook. All rights reserved.
//

import UIKit

final class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

  private let cellCount: Int
  private lazy var dataSource = CollectionViewDataSource(cellCount: cellCount)

  init(cellCount: Int) {
    self.cellCount = cellCount

    let size = NSCollectionLayoutSize(
        widthDimension: NSCollectionLayoutDimension.fractionalWidth(1),
        heightDimension: NSCollectionLayoutDimension.estimated(44)
    )
    let item = NSCollectionLayoutItem(layoutSize: size)
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitem: item, count: 1)

    let section = NSCollectionLayoutSection(group: group)

    section.interGroupSpacing = 10

    let layout = UICollectionViewCompositionalLayout(section: section)

    super.init(collectionViewLayout: layout)

    collectionView.collectionViewLayout = layout
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    collectionView.backgroundColor = .systemBackground
    collectionView.dataSource = dataSource
    collectionView.delegate = self
    collectionView.register(cell: HeadlineSummaryCell.self)
    collectionView.register(cell: ThumbnailCell.self)
  }
}

final private class CollectionViewDataSource: NSObject, UICollectionViewDataSource {

  private let cellCount: Int

  init(cellCount: Int) {
    self.cellCount = cellCount
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return cellCount
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let headline = ContentGenerator.words(min: 2,8)
    let summary = ContentGenerator.words(min: 20,40)

    switch indexPath.row % 2 {
    case 0:
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeadlineSummaryCell.cellIdentifier, for: indexPath) as! HeadlineSummaryCell
      cell.set(headline: headline, summary: summary)
      return cell
    case 1:
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ThumbnailCell.cellIdentifier, for: indexPath) as! ThumbnailCell
      cell.set(headline: headline, summary: summary)
      return cell
    default:
      fatalError()
    }
  }
}

protocol Identifiable {
  static var cellIdentifier: String { get }
}

extension Identifiable {
  static var cellIdentifier: String {
    return String(describing: self)
  }
}

extension UICollectionView {
  func register<T: UICollectionViewCell>(cell: T.Type) where T: Identifiable {
    register(cell, forCellWithReuseIdentifier: cell.cellIdentifier)
  }
}

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

final class HeadlineSummaryCell: UICollectionViewCell, Identifiable {

  private lazy var headlineView: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    return label
  }()

  private lazy var summaryView: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    return label
  }()

  private let footerView = FooterView()

  override init(frame: CGRect) {
    super.init(frame: frame)

    backgroundColor = .white

    let stackView = UIStackView(arrangedSubviews: [headlineView, summaryView, footerView])
    stackView.axis = .vertical
    stackView.distribution = .fill
    stackView.spacing = 5

    contentView.addSubview(stackView)

    stackView.pinEdges(to: contentView)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func set(headline: String, summary: String) {
    headlineView.attributedText = NSAttributedString(
      string: headline,
      attributes: [
        NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18),
        NSAttributedString.Key.foregroundColor: UIColor.black
      ]
    )

    summaryView.attributedText = NSAttributedString(
      string: summary,
      attributes: [
        NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14),
        NSAttributedString.Key.foregroundColor: UIColor.darkGray
      ]
    )
  }
}

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

    backgroundColor = .white

    let buttonStackView = UIStackView(arrangedSubviews: [shareButton, saveButton])
    buttonStackView.axis = .horizontal
    buttonStackView.spacing = 5
    buttonStackView.distribution = .fillEqually

    let stackView = UIStackView(arrangedSubviews: [dateView, buttonStackView])
    stackView.axis = .horizontal
    stackView.distribution = .fill
    stackView.isLayoutMarginsRelativeArrangement = true
    stackView.layoutMargins = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)

    addSubview(stackView)

    stackView.pinEdgesToSuperView()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

final class ThumbnailCell: UICollectionViewCell, Identifiable {

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
