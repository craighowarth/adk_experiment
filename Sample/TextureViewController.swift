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
    let headline = Self.words(min: 2,8)
    let summary = Self.words(min: 20,40)
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

  private static func words(min: Int, _ max: Int) -> String {
    let wordList = [
      "alias", "consequatur", "aut", "sit", "voluptatem",
      "accusantium", "doloremque", "aperiam", "eaque", "ipsa", "quae", "ab",
      "illo", "inventore", "veritatis", "et", "quasi", "architecto",
      "beatae", "vitae", "dicta", "sunt", "explicabo", "aspernatur", "aut",
      "odit", "aut", "fugit", "sed", "quia", "consequuntur", "magni",
      "dolores", "eos", "qui", "ratione", "voluptatem", "sequi", "nesciunt",
      "neque", "dolorem", "ipsum", "quia", "dolor", "sit", "amet",
      "consectetur", "adipisci", "velit", "sed", "quia", "non", "numquam",
      "eius", "modi", "tempora", "incidunt", "ut", "labore", "et", "dolore",
      "magnam", "aliquam", "quaerat", "voluptatem", "ut", "enim", "ad",
      "minima", "veniam", "quis", "nostrum", "exercitationem", "ullam",
      "corporis", "nemo", "enim", "ipsam", "voluptatem", "quia", "voluptas",
      "sit", "suscipit", "laboriosam", "nisi", "ut", "aliquid", "ex", "ea",
      "commodi", "consequatur", "quis", "autem", "vel", "eum", "iure",
      "reprehenderit", "qui", "in", "ea", "voluptate", "velit", "esse",
      "quam", "nihil", "molestiae", "et", "iusto", "odio", "dignissimos",
      "ducimus", "qui", "blanditiis", "praesentium", "laudantium", "totam",
      "rem", "voluptatum", "deleniti", "atque", "corrupti", "quos",
      "dolores", "et", "quas", "molestias", "excepturi", "sint",
      "occaecati", "cupiditate", "non", "provident", "sed", "ut",
      "perspiciatis", "unde", "omnis", "iste", "natus", "error",
      "similique", "sunt", "in", "culpa", "qui", "officia", "deserunt",
      "mollitia", "animi", "id", "est", "laborum", "et", "dolorum", "fuga",
      "et", "harum", "quidem", "rerum", "facilis", "est", "et", "expedita",
      "distinctio", "nam", "libero", "tempore", "cum", "soluta", "nobis",
      "est", "eligendi", "optio", "cumque", "nihil", "impedit", "quo",
      "porro", "quisquam", "est", "qui", "minus", "id", "quod", "maxime",
      "placeat", "facere", "possimus", "omnis", "voluptas", "assumenda",
      "est", "omnis", "dolor", "repellendus", "temporibus", "autem",
      "quibusdam", "et", "aut", "consequatur", "vel", "illum", "qui",
      "dolorem", "eum", "fugiat", "quo", "voluptas", "nulla", "pariatur",
      "at", "vero", "eos", "et", "accusamus", "officiis", "debitis", "aut",
      "rerum", "necessitatibus", "saepe", "eveniet", "ut", "et",
      "voluptates", "repudiandae", "sint", "et", "molestiae", "non",
      "recusandae", "itaque", "earum", "rerum", "hic", "tenetur", "a",
      "sapiente", "delectus", "ut", "aut", "reiciendis", "voluptatibus",
      "maiores", "doloribus", "asperiores", "repellat"
    ]
    
    let count: Int = Int(arc4random_uniform(UInt32(max - min))) + min;
    
    var result = "START "
    (0..<count).forEach { idx in
      result += wordList[idx % wordList.count] + " "
    }
    result += "END"
    
    return result
  }
}
