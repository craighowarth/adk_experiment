//
//  ScrollPerformanceTests.swift
//  SampleUITests
//
//  Created by Jonathan Lazar on 9/2/20.
//  Copyright © 2020 Facebook. All rights reserved.
//

import XCTest

class ScrollPerformanceTests: XCTestCase {

  func testTextureScrollPerformance() throws {
    let app = XCUIApplication()
    app.launch()
    let table = app.tables.firstMatch

    let measureOptions = XCTMeasureOptions()
    measureOptions.invocationOptions = [.manuallyStop]

    if #available(iOS 14.0, *) {
      measure(metrics: [XCTOSSignpostMetric.scrollDecelerationMetric], options: measureOptions) {
        table.swipeUp(velocity: .fast)
        stopMeasuring()
        table.swipeDown(velocity: .fast)
      }
    }
  }
}
