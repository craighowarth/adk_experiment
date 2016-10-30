//
//  WebCellNode.swift
//  Sample
//
//  Created by Craig Howarth on 10/30/16.
//  Copyright © 2016 Facebook. All rights reserved.
//

import AsyncDisplayKit
import UIKit
import WebKit

final class WebCellNode: ASCellNode {
  var disclaimerNode = ASTextNode()
  var webNode = ASDisplayNode()
  var webView: WKWebView?
  var url: NSURL = NSURL()
  var height: CGFloat = 0
  
  convenience init(url: NSURL, height: CGFloat) {
    self.init()
    self.url = url
    self.height = height
    
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.alignment = .Center

    disclaimerNode.attributedText = NSAttributedString(
      string: "ADVERTISEMENT",
      attributes: [
        NSFontAttributeName: UIFont.systemFontOfSize(9.0),
        NSParagraphStyleAttributeName: paragraphStyle,
        NSForegroundColorAttributeName: UIColor.lightGrayColor()
      ])
    
    addSubnode(disclaimerNode)
    addSubnode(webNode)
  }
  
  override init() {
    super.init()
  }

  override func didLoad() {
    super.didLoad()
    webView = WKWebView(frame: webNode.bounds)
    webView?.scrollView.scrollEnabled = false
    if let webView = webView {
      webView.loadRequest(NSURLRequest(URL: url))
      webNode.view.addSubview(webView)
    }
  }
  
  override func layout() {
    super.layout()
    webView?.frame = webNode.bounds
  }
  
  override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
    let nodeMargin: CGFloat = 10.0
    let insetWidth = constrainedSize.max.width - (nodeMargin * 2.0)
    webNode.bounds = CGRect(x: 0, y: 0, width: insetWidth, height: height)
    webNode.style.preferredSize = CGSize(width: insetWidth, height: height)

    let verticalStackSpec = ASStackLayoutSpec.verticalStackLayoutSpec()
    verticalStackSpec.children = [ disclaimerNode, webNode ]
    verticalStackSpec.spacing = 10.0
    
    let insets = UIEdgeInsets(top: nodeMargin, left: nodeMargin, bottom: nodeMargin, right: nodeMargin)
    return ASInsetLayoutSpec(insets: insets, child: verticalStackSpec)
  }
}
