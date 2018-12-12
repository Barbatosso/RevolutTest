//
//  TestConfigurableCell.swift
//  RevolutTestTests
//
//  Created by Egor Petrov on 12/12/2018.
//  Copyright © 2018 Egor Petrov. All rights reserved.
//

import XCTest

class TestConfigurableCell: XCTestCase {

  private var configurableCell: MockConfigurableTableViewCell!

  override func setUp() {
    configurableCell = MockConfigurableTableViewCell()
  }

  override func tearDown() {
    configurableCell = nil
  }

  func testConfigureCell() {
    XCTAssertTrue(configurableCell.title.isEmpty, "Cell title must be empty before test")

    let data = MockCellData(title: "Hello")

    configurableCell.configure(with: data)

    XCTAssert(configurableCell.title == data.title, "Title after configure must be \(data.title)")
  }

  func testReuseId() {
    let reuseId = String(describing: MockConfigurableTableViewCell.self)

    XCTAssert(MockConfigurableTableViewCell.reuseId == reuseId)
  }
}
