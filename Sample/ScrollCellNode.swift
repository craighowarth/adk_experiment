//
//  ScrollCellNode.swift
//  Sample
//
//  Created by Howarth, Craig on 11/1/16.
//  Copyright © 2016 Facebook. All rights reserved.
//

import AsyncDisplayKit
import UIKit

final class ScrollCellNode: ASCellNode, ASCollectionDelegate, ASCollectionDataSource {
  var collectionNode = ASCollectionNode(collectionViewLayout: UICollectionViewFlowLayout())
  var elementSize = CGSize(width: 200, height: 300)
  var numberOfItems: Int = 0

  convenience init(numberOfItems: Int) {
    self.init()

    self.numberOfItems = numberOfItems

    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.scrollDirection = UICollectionViewScrollDirection.Horizontal
    flowLayout.itemSize = elementSize
    flowLayout.minimumInteritemSpacing = 10

    collectionNode = ASCollectionNode(collectionViewLayout: flowLayout)
    collectionNode.delegate = self
    collectionNode.dataSource = self

    addSubnode(collectionNode)
  }

  override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
    let nodeMargin: CGFloat = 10.0

    let collectionNodeSize = CGSize(width: constrainedSize.max.width, height: elementSize.height)
    collectionNode.style.preferredSize = collectionNodeSize

    let insets = UIEdgeInsets(top: nodeMargin, left: nodeMargin, bottom: nodeMargin, right: nodeMargin)
    return ASInsetLayoutSpec(insets: insets, child: collectionNode)

  }

  func collectionNode(collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
    return numberOfItems
  }

  func collectionNode(collectionNode: ASCollectionNode, nodeBlockForItemAtIndexPath indexPath: NSIndexPath) -> ASCellNodeBlock {
    let elementSize = self.elementSize
    return { () -> ASCellNode in
      let crop = Crop(imageFilename: "miles.png", size: CGSize(width: 560, height: 560))
      let elementNode = LargeImageCellNode(headline: "Miles Davis", summary: "Miles Dewey Davis III was an American jazz trumpeter, bandleader, and composer.", kicker: "", credit: "", crop: crop)
      elementNode.style.preferredSize = elementSize
      return elementNode
    }
  }
}
