//
//  FooterNode.swift
//  Sample
//
//  Created by Howarth, Craig on 11/1/16.
//  Copyright © 2016 Facebook. All rights reserved.
//

import AsyncDisplayKit
import UIKit

final class FooterNode: ASDisplayNode {
  var dateNode = ASTextNode()
  var shareButtonNode = ASButtonNode()
  var saveButtonNode = ASButtonNode()

  override init() {
    super.init()

    let formatter = NSDateFormatter()
    formatter.dateFormat = "MMM d"
    let displayDate = formatter.stringFromDate(NSDate())

    dateNode.attributedText = NSAttributedString(
      string: displayDate,
      attributes: [
        NSFontAttributeName: UIFont.systemFontOfSize(12),
        NSForegroundColorAttributeName: UIColor.grayColor()
      ])

    shareButtonNode.setImage(UIImage(named: "NYTShareIcon"), forState: ASControlState.Normal)
    saveButtonNode.setImage(UIImage(named: "NYTSaveIcon"), forState: ASControlState.Normal)

    addSubnode(dateNode)
    addSubnode(shareButtonNode)
    addSubnode(saveButtonNode)
  }

  override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
    let buttonGroupSpec = ASStackLayoutSpec.horizontalStackLayoutSpec()
    buttonGroupSpec.children = [ saveButtonNode, shareButtonNode ]
    buttonGroupSpec.spacing = 5.0

    let spacerSpec = ASLayoutSpec()
    spacerSpec.style.flexGrow = 1.0
    spacerSpec.style.flexShrink = 1.0

    let layoutSpec = ASStackLayoutSpec.horizontalStackLayoutSpec()
    layoutSpec.children = [dateNode, spacerSpec, buttonGroupSpec]
    layoutSpec.alignItems = ASStackLayoutAlignItems.Center
    layoutSpec.justifyContent = ASStackLayoutJustifyContent.Start

    return layoutSpec
  }
}
