//
//  TestTableRow.swift
//  RevolutTestTests
//
//  Created by Egor Petrov on 12/12/2018.
//  Copyright © 2018 Egor Petrov. All rights reserved.
//

import XCTest

class TestTableRow: XCTestCase {

  private var mockTableRow: MockTableRow!
  private var mockData: MockCellData!
  private var mockTableViewCell: MockConfigurableTableViewCell!

  override func setUp() {
    mockData = MockCellData(title: "Hello")
    mockTableRow = MockTableRow(data: mockData)
    mockTableViewCell = MockConfigurableTableViewCell()
  }

  override func tearDown() {
    mockData = nil
    mockTableRow = nil
    mockTableViewCell = nil
  }

  func testRowConfigure() {
    XCTAssertTrue(mockTableRow.title.isEmpty, "Cell title must be empty before test")

    mockTableRow.configure(mockTableViewCell)

    XCTAssert(!mockTableRow.title.isEmpty && mockTableRow.title == mockData.title)
  }

  func testReuseId() {
    let reuseId = String(describing: MockConfigurableTableViewCell.self)
    XCTAssert(mockTableRow.reuseId == reuseId)
  }

  func testCellType() {
    XCTAssert(mockTableRow.cellType is MockConfigurableTableViewCell.Type)
  }

  func testOnTap() {
    XCTAssertTrue(mockTableRow.onTap())
  }

  func testIsEqualRow() {
    XCTAssertTrue(mockTableRow.isEqual(to: mockTableRow))

    let negativeCellData = MockCellData(title: "World")
    let negativeMockTableRow = MockTableRow(data: negativeCellData)

    XCTAssertFalse(mockTableRow.isEqual(to: negativeMockTableRow))
  }
}
