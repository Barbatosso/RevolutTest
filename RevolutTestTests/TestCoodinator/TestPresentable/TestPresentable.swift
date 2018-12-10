//
//  TestPresentable.swift
//  RevolutTestTests
//
//  Created by Egor Petrov on 10/12/2018.
//  Copyright © 2018 Egor Petrov. All rights reserved.
//

import XCTest

class TestPresentable: XCTestCase {

  private var presentable: Presentable!

  override func setUp() {
    super.setUp()
    presentable = MockViewController()
  }

  override func tearDown() {
    super.tearDown()
    presentable = nil
  }

  func testViewControllerToPresent() {
    XCTAssertNotNil(presentable.toPresent())
  }
}
