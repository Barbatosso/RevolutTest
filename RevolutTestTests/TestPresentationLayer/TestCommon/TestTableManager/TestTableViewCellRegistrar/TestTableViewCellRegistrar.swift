//
//  TestTableViewCellRegistrar.swift
//  RevolutTestTests
//
//  Created by Egor Petrov on 12/12/2018.
//  Copyright © 2018 Egor Petrov. All rights reserved.
//

import XCTest

class TestTableViewCellRegistrar: XCTestCase {

  private var tableView: UITableView!
  private var registrar: TableViewCellRegistrar!

  override func setUp() {
    tableView = UITableView()
    registrar = TableViewCellRegistrarImpl(tableView: tableView)
  }

  override func tearDown() {
    tableView = nil
    registrar = nil
  }

  func testRegisterCell() {
    registrar.register(MockConfigurableTableViewCell.self, for: MockConfigurableTableViewCell.reuseId)

    XCTAssertFalse(registrar.registeredIds.isEmpty)
    XCTAssertTrue(registrar.registeredIds.contains(MockConfigurableTableViewCell.reuseId))
  }

  func testRegisterTheSameCell() {
    registrar.register(MockConfigurableTableViewCell.self, for: MockConfigurableTableViewCell.reuseId)
    registrar.register(MockConfigurableTableViewCell.self, for: MockConfigurableTableViewCell.reuseId)

    XCTAssertFalse(registrar.registeredIds.count == 2)
  }
}
