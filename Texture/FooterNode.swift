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

    let formatter = DateFormatter()
    formatter.dateFormat = "MMM d"
    let displayDate = formatter.string(from: Date())

    dateNode.attributedText = NSAttributedString(
      string: displayDate,
      attributes: [
        .font: UIFont.systemFont(ofSize: 12),
        .foregroundColor: UIColor.gray
      ])

    shareButtonNode.setImage(UIImage(named: "NYTShareIcon"), for: .normal)
    saveButtonNode.setImage(UIImage(named: "NYTSaveIcon"), for: .normal)

    addSubnode(dateNode)
    addSubnode(shareButtonNode)
    addSubnode(saveButtonNode)
  }

  override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
    let buttonGroupSpec = ASStackLayoutSpec.horizontal()
    buttonGroupSpec.children = [ saveButtonNode, shareButtonNode ]
    buttonGroupSpec.spacing = 5.0

    let spacerSpec = ASLayoutSpec()
    spacerSpec.style.flexGrow = 1.0
    spacerSpec.style.flexShrink = 1.0

    let layoutSpec = ASStackLayoutSpec.horizontal()
    layoutSpec.children = [dateNode, spacerSpec, buttonGroupSpec]
    layoutSpec.alignItems = ASStackLayoutAlignItems.center
    layoutSpec.justifyContent = ASStackLayoutJustifyContent.start

    return layoutSpec
  }
}
