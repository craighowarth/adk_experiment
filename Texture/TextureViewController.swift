//
//  ViewController.swift
//  Sample
//
//  Copyright (c) 2014-present, Facebook, Inc.  All rights reserved.
//  This source code is licensed under the BSD-style license found in the
//  LICENSE file in the root directory of this source tree. An additional grant
//  of patent rights can be found in the PATENTS file in the same directory.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
//  FACEBOOK BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
//  ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
//  CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

import UIKit
import AsyncDisplayKit

final class TextureViewController: ASDKViewController<ASDisplayNode>, ASTableDataSource, ASTableDelegate {
  struct State {
    var itemCount: Int
    var fetchingMore: Bool
    static let empty = State(itemCount: 20, fetchingMore: false)
  }

  var tableNode: ASTableNode {
    return node as! ASTableNode
  }

  private let cellCount: Int
  private(set) var state: State = .empty

  init(cellCount: Int) {
    self.cellCount = cellCount
    super.init(node: ASTableNode())
    tableNode.delegate = self
    tableNode.dataSource = self
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("storyboards are incompatible with truth and beauty")
  }

  private override init() {
    fatalError("init() is not supported. use init(data:) instead.")
  }

  // MARK: ASTableView data source and delegate.

  func tableView(_ tableView: ASTableView, nodeForRowAt indexPath: IndexPath) -> ASCellNode {
    let headline = ContentGenerator.words(min: 2,8)
    let summary = ContentGenerator.words(min: 20,40)
    let node: ASCellNode
    let itemNumber = indexPath.row + 1
    if itemNumber % 5 == 0 {
      node = ScrollCellNode(numberOfItems: 10)
    } else if itemNumber % 4 == 0 {
      let url = NSURL(string: "https://secure-ds.serving-sys.com/BurstingRes/Site-85296/WSFolders/7649898/TH029_728x90_r3.hyperesources/TH029_728x90_GiGi.jpg")!
      node = WebCellNode(url: url, height: 50)
    } else if itemNumber % 3 == 0 {
      let crop = Crop(imageFilename: "coltrane.jpg", size: CGSize(width: 540, height: 300))
      node = LargeImageCellNode(headline: headline, summary: summary, kicker: "KICKER", credit: "Photo by Joe Blow", crop: crop)
    } else if itemNumber % 2 == 0 {
      node = ThumbnailCellNode(headline: headline, summary: summary)
    } else {
      node = HeadlineSummaryCellNode(headline: headline, summary: summary)
    }

    node.selectionStyle = UITableViewCell.SelectionStyle.none

    return node
  }

  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return cellCount
  }
}
