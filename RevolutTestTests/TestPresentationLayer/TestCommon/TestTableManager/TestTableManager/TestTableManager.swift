//
//  TestTableManager.swift
//  RevolutTestTests
//
//  Created by Egor Petrov on 12/12/2018.
//  Copyright © 2018 Egor Petrov. All rights reserved.
//

import XCTest

class TestTableManager: XCTestCase {

  private var tableManager: TableManager!

  override func setUp() {
    tableManager = TableManagerImpl()
  }
  
  override func tearDown() {
    tableManager = nil
  }
  
  func testAppendRow() {
    tableManager.removeAll()
    XCTAssertTrue(tableManager.isEmpty, "Table manager rows must be empty before test")

    let tableData = MockCellData(title: "Hello")
    let mockTableRow = MockTableRow(data: tableData)

    tableManager.append(newRow: mockTableRow)

    XCTAssertFalse(tableManager.isEmpty)
  }

  func testAppendSequenceOfRows() {
    tableManager.removeAll()
    XCTAssertTrue(tableManager.isEmpty, "Table manager rows must be empty before test")

    let tableData = MockCellData(title: "Hello")
    let mockTableRow = MockTableRow(data: tableData)
    let tableData1 = MockCellData(title: "Hello")
    let mockTableRow1 = MockTableRow(data: tableData)

    tableManager.append(newRows: [mockTableRow, mockTableRow1])
    XCTAssert(!tableManager.isEmpty && tableManager.rows.count == 2)
  }
}
