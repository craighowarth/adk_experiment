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
    let layout = CollectionViewController.layout
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
    collectionView.register(cell: LargeImageCell.self)
  }

  private static let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
    sectionIndex.isCarouselSection ? carouselLayoutSection : defaultLayoutSection
  }

  private static let carouselLayoutSection: NSCollectionLayoutSection = {
    let itemSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1.0),
      heightDimension: .absolute(300.0)
    )
    let item = NSCollectionLayoutItem(layoutSize: itemSize)

    let groupSize = NSCollectionLayoutSize(
      widthDimension: .absolute(200.0),
      heightDimension: .estimated(300.0)
    )
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
    let section = NSCollectionLayoutSection(group: group)
    section.orthogonalScrollingBehavior = .continuous
    section.interGroupSpacing = 10
    section.contentInsets = .init(top: 10, leading: 10, bottom: 0, trailing: 10)
    return section
  }()

  private static let defaultLayoutSection: NSCollectionLayoutSection = {
    let size = NSCollectionLayoutSize(
        widthDimension: NSCollectionLayoutDimension.fractionalWidth(1),
        heightDimension: NSCollectionLayoutDimension.estimated(44)
    )
    let item = NSCollectionLayoutItem(layoutSize: size)
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitem: item, count: 1)
    let section = NSCollectionLayoutSection(group: group)
    section.contentInsets = .init(top: 10, leading: 0, bottom: 0, trailing: 0)
    return section
  }()
}

final private class CollectionViewDataSource: NSObject, UICollectionViewDataSource {

  private let cellCount: Int

  init(cellCount: Int) {
    self.cellCount = cellCount
  }

  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return cellCount
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return section.isCarouselSection ? 10 : 1
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let headline = ContentGenerator.words(min: 2,8)
    let summary = ContentGenerator.words(min: 20,40)

    if indexPath.section.isCarouselSection {
      let cell: LargeImageCell = collectionView.dequeue(for: indexPath)
      cell.set(
        headline: "Miles Davis",
        summary: "Miles Dewey Davis III was an American jazz trumpeter, bandleader, and composer.",
        image: "miles.png"
      )
      return cell
    } else if indexPath.section.isHeadlineSummarySection {
      let cell: HeadlineSummaryCell = collectionView.dequeue(for: indexPath)
      cell.set(headline: headline, summary: summary)
      return cell
    } else {
      let cell: ThumbnailCell = collectionView.dequeue(for: indexPath)
      cell.set(headline: headline, summary: summary)
      return cell
    }
  }
}

private extension Int {
  var isCarouselSection: Bool {
    return (self + 1) % 5 == 0
  }

  var isHeadlineSummarySection: Bool {
    return (self + 1) % 4 == 0
  }
}
