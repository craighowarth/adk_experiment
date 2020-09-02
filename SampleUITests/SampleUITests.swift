//
//  SampleUITests.swift
//  SampleUITests
//
//  Created by Jonathan Lazar on 9/2/20.
//  Copyright © 2020 Facebook. All rights reserved.
//

import XCTest

class SampleUITests: XCTestCase {

  func testTextureScrollingPerformance() throws {
    // UI tests must launch the application that they test.
    let app = XCUIApplication()
    app.launch()
    let table = app.tables.firstMatch

    if #available(iOS 14.0, *) {
      measure(metrics: [XCTOSSignpostMetric.scrollDecelerationMetric]) {
        table.swipeUp(velocity: .fast)
      }
    }
  }

  func testLaunchPerformance() throws {
    if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
      // This measures how long it takes to launch your application.
      measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
        XCUIApplication().launch()
      }
    }
  }
}
