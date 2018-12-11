//
//  TestViewHolder.swift
//  RevolutTestTests
//
//  Created by Egor Petrov on 12/12/2018.
//  Copyright © 2018 Egor Petrov. All rights reserved.
//

import XCTest

class TestViewHolder: XCTestCase {

  private var viewHolder: MockViewHolderViewController!

  override func setUp() {
    viewHolder = MockViewHolderViewController()
  }

  override func tearDown() {
    viewHolder = nil
  }

  func testViewHolder() {
    XCTAssertTrue(viewHolder.view is MockViewHolderView)
  }
}
