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
      let cell: HeadlineSummaryCell = collectionView.dequeue(for: indexPath)
      cell.set(headline: headline, summary: summary)
      return cell
    case 1:
      let cell: ThumbnailCell = collectionView.dequeue(for: indexPath)
      cell.set(headline: headline, summary: summary)
      return cell
    default:
      fatalError()
    }
  }
}

protocol Reusable {
  static var reuseIdentifier: String { get }
}

extension Reusable {
  static var reuseIdentifier: String {
    return String(describing: self)
  }
}

extension UICollectionView {
  func register<T: UICollectionViewCell & Reusable>(cell: T.Type) {
    register(cell, forCellWithReuseIdentifier: cell.reuseIdentifier)
  }

  func dequeue<T: UICollectionViewCell & Reusable>(for indexPath: IndexPath) -> T {
    dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as! T
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
