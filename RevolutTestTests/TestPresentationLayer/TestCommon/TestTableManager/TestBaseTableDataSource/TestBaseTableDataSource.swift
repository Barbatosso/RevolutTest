//
//  TestBaseTableDataSource.swift
//  RevolutTestTests
//
//  Created by Egor Petrov on 12/12/2018.
//  Copyright © 2018 Egor Petrov. All rights reserved.
//

import XCTest

class TestBaseTableDataSource: XCTestCase {

  private var tableManager: TableManager!
  private var tableView: UITableView!

  override func setUp() {
    tableView = UITableView()
    tableManager = TableManagerImpl()
  }

  override func tearDown() {
    tableView = nil
    tableManager = nil
  }

  func testDataSource() {
    tableManager.connect(to: tableView, with: BaseTableDataSource.self, tableDelegate: FundsTableDelegate.self)

    let cellData = MockCellData(title: "Hello")
    let mockRow = MockTableRow(data: cellData)
    tableManager.append(newRow: mockRow)
    tableManager.reload()

    XCTAssert(tableView.numberOfRows(inSection: 0) == 1)
    XCTAssertFalse(tableView.visibleCells.isEmpty)
  }
}
