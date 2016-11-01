//
//  HeadlineSummaryCellNode.swift
//  Sample
//
//  Created by Craig Howarth on 10/19/16.
//  Copyright © 2016 Facebook. All rights reserved.
//

import AsyncDisplayKit
import UIKit

final class HeadlineSummaryCellNode: ASCellNode {
  var headlineNode = ASTextNode()
  var summaryNode = ASTextNode()
  
  convenience init(headline: String, summary: String) {
    self.init()
    
    headlineNode.attributedText = NSAttributedString(
      string: headline,
      attributes: [
        NSFontAttributeName: UIFont.boldSystemFontOfSize(18),
        NSForegroundColorAttributeName: UIColor.blackColor()
      ])

    summaryNode.attributedText = NSAttributedString(
      string: summary,
      attributes: [
        NSFontAttributeName: UIFont.systemFontOfSize(14),
        NSForegroundColorAttributeName: UIColor.darkGrayColor()
      ])

    addSubnode(headlineNode)
    addSubnode(summaryNode)
  }

  override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
    let verticalStackSpec = ASStackLayoutSpec.verticalStackLayoutSpec()
    verticalStackSpec.children = [ headlineNode, summaryNode ]
    verticalStackSpec.spacing = 16.0

    let insets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    let insetSpec = ASInsetLayoutSpec(insets: insets, child: verticalStackSpec)
    
    return insetSpec
  }
}
