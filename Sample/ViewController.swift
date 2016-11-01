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

final class ViewController: ASViewController, ASTableDataSource, ASTableDelegate {
  var showWebViews = false

  struct State {
    var itemCount: Int
    var fetchingMore: Bool
    static let empty = State(itemCount: 20, fetchingMore: false)
  }

  enum Action {
    case BeginBatchFetch
    case EndBatchFetch(resultCount: Int)
  }

  var tableNode: ASTableNode {
    return node as! ASTableNode
  }

  private(set) var state: State = .empty

  init() {
    super.init(node: ASTableNode())
    tableNode.delegate = self
    tableNode.dataSource = self
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("storyboards are incompatible with truth and beauty")
  }

  // MARK: ASTableView data source and delegate.

  func tableView(tableView: ASTableView, nodeForRowAtIndexPath indexPath: NSIndexPath) -> ASCellNode {
    // Should read the row count directly from table view but
    // https://github.com/facebook/AsyncDisplayKit/issues/1159
    let rowCount = self.tableView(tableView, numberOfRowsInSection: 0)

    if state.fetchingMore && indexPath.row == rowCount - 1 {
      return TailLoadingCellNode()
    }

    let headline = ViewController.words(2,8)
    let summary = ViewController.words(20,40)
    let node: ASCellNode
    let itemNumber = indexPath.row + 1
    if itemNumber % 5 == 0 {
      node = ScrollCellNode(numberOfItems: 10)
    } else if itemNumber % 4 == 0 && showWebViews {
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

    node.selectionStyle = UITableViewCellSelectionStyle.None

    return node
  }

  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }

  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    var count = state.itemCount
    if state.fetchingMore {
      count += 1
    }
    return count
  }

  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    showWebViews = !showWebViews
    tableView.reloadData()
  }

  func tableView(tableView: ASTableView, willBeginBatchFetchWithContext context: ASBatchContext) {
    /// This call will come in on a background thread. Switch to main
    /// to add our spinner, then fire off our fetch.
    dispatch_async(dispatch_get_main_queue()) {
      let oldState = self.state
      self.state = ViewController.handleAction(.BeginBatchFetch, fromState: oldState)
      self.renderDiff(oldState)
    }

    ViewController.fetchDataWithCompletion { resultCount in
      let action = Action.EndBatchFetch(resultCount: resultCount)
      let oldState = self.state
      self.state = ViewController.handleAction(action, fromState: oldState)
      self.renderDiff(oldState)
      context.completeBatchFetching(true)
    }
  }

  private func renderDiff(oldState: State) {
    let tableView = tableNode.view
    tableView.beginUpdates()

    // Add or remove items
    let rowCountChange = state.itemCount - oldState.itemCount
    if rowCountChange > 0 {
      let indexPaths = (oldState.itemCount..<state.itemCount).map { index in
        NSIndexPath(forRow: index, inSection: 0)
      }
      tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .None)
    } else if rowCountChange < 0 {
      assertionFailure("Deleting rows is not implemented. YAGNI.")
    }

    // Add or remove spinner.
    if state.fetchingMore != oldState.fetchingMore {
      if state.fetchingMore {
        // Add spinner.
        let spinnerIndexPath = NSIndexPath(forRow: state.itemCount, inSection: 0)
        tableView.insertRowsAtIndexPaths([ spinnerIndexPath ], withRowAnimation: .None)
      } else {
        // Remove spinner.
        let spinnerIndexPath = NSIndexPath(forRow: oldState.itemCount, inSection: 0)
        tableView.deleteRowsAtIndexPaths([ spinnerIndexPath ], withRowAnimation: .None)
      }
    }
    tableView.endUpdatesAnimated(false, completion: nil)
  }

  /// (Pretend) fetches some new items and calls the
  /// completion handler on the main thread.
  private static func fetchDataWithCompletion(completion: (Int) -> Void) {
    let time = dispatch_time(DISPATCH_TIME_NOW, Int64(NSTimeInterval(NSEC_PER_SEC) * 1.0))
    dispatch_after(time, dispatch_get_main_queue()) {
      let resultCount = Int(arc4random_uniform(20))
      completion(resultCount)
    }
  }

  private static func handleAction(action: Action, fromState state: State) -> State {
    var state = state
    switch action {
    case .BeginBatchFetch:
      state.fetchingMore = true
    case let .EndBatchFetch(resultCount):
      state.itemCount += resultCount
      state.fetchingMore = false
    }
    return state
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
