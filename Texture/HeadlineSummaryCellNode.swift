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
  var footerNode = FooterNode()
  
  convenience init(headline: String, summary: String) {
    self.init()
    
    headlineNode.attributedText = NSAttributedString(
      string: headline,
      attributes: [
        .font: UIFont.boldSystemFont(ofSize: 18),
        .foregroundColor: UIColor.black
      ])

    summaryNode.attributedText = NSAttributedString(
      string: summary,
      attributes: [
        .font: UIFont.systemFont(ofSize: 14),
        .foregroundColor: UIColor.darkGray
      ])

    addSubnode(headlineNode)
    addSubnode(summaryNode)
    addSubnode(footerNode)
  }

  override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
    let headlineSummaryStackSpec = ASStackLayoutSpec.vertical()
    headlineSummaryStackSpec.children = [ headlineNode, summaryNode ]
    headlineSummaryStackSpec.spacing = 16.0

    let verticalStackSpec = ASStackLayoutSpec.vertical()
    verticalStackSpec.children = [ headlineSummaryStackSpec, footerNode ]
    verticalStackSpec.spacing = 10.0

    let insets = UIEdgeInsets(all: 10)
    let insetSpec = ASInsetLayoutSpec(insets: insets, child: verticalStackSpec)
    
    return insetSpec
  }
}
