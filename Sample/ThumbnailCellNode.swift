//
//  ThumbnailCellNode.swift
//  Sample
//
//  Created by Craig Howarth on 10/19/16.
//  Copyright © 2016 Facebook. All rights reserved.
//

import AsyncDisplayKit
import UIKit

final class ThumbnailCellNode: ASCellNode {
  var textNode = ASTextNode()
  var thumbnailNode = ASImageNode()
  var footerNode = FooterNode()
  let thumbnailSize = CGSize(width: 75.0, height: 75.0)
  
  convenience init(headline: String, summary: String) {
    self.init()
    
    let headlineAttributedString = NSAttributedString(
      string: "\(headline)\n",
      attributes: [
        NSFontAttributeName: UIFont.boldSystemFontOfSize(18),
        NSForegroundColorAttributeName: UIColor.blackColor()
      ])
    let spacerAttributedString = NSAttributedString(
      string: "\n",
      attributes: [
        NSFontAttributeName: UIFont.systemFontOfSize(10)
      ])
    let summaryAttributedString = NSAttributedString(
      string: summary,
      attributes: [
        NSFontAttributeName: UIFont.systemFontOfSize(14),
        NSForegroundColorAttributeName: UIColor.darkGrayColor()
      ])
    
    let attributedString = NSMutableAttributedString()
    attributedString.appendAttributedString(headlineAttributedString)
    attributedString.appendAttributedString(spacerAttributedString)
    attributedString.appendAttributedString(summaryAttributedString)
    
    textNode.attributedText = attributedString
    
    thumbnailNode.image = UIImage(named: "thumbnail.jpg")
    thumbnailNode.contentMode = .ScaleAspectFill
    thumbnailNode.style.preferredSize = thumbnailSize

    addSubnode(textNode)
    addSubnode(thumbnailNode)
    addSubnode(footerNode)
  }
  
  override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
    let thumbnailSpec = ASRelativeLayoutSpec(horizontalPosition: .End, verticalPosition: .Start, sizingOption: .Default, child: thumbnailNode)

    let nodeMargin: CGFloat = 10.0
    let insetWidth = constrainedSize.max.width - (nodeMargin * 2.0)
    let thumbnailMargin: CGFloat = 10.0
    let thumbnailWidth = thumbnailSize.width + thumbnailMargin
    let thumbnailHeight = thumbnailSize.height + thumbnailMargin
    let thumbnailXPos = insetWidth - thumbnailWidth
    let exclusionPath = UIBezierPath(rect: CGRect(x: thumbnailXPos, y: 0, width: thumbnailWidth, height: thumbnailHeight))
    textNode.exclusionPaths = [exclusionPath]

    let overlaySpec = ASOverlayLayoutSpec(child: textNode, overlay: thumbnailSpec)

    let verticalStackSpec = ASStackLayoutSpec.verticalStackLayoutSpec()
    verticalStackSpec.children = [ overlaySpec, footerNode ]
    verticalStackSpec.spacing = 10.0

    let insets = UIEdgeInsets(top: nodeMargin, left: nodeMargin, bottom: nodeMargin, right: nodeMargin)
    let insetSpec = ASInsetLayoutSpec(insets: insets, child: verticalStackSpec)
    
    return insetSpec
  }
}
