//
//  TableManager.swift
//  RevolutTest
//
//  Created by Egor Petrov on 02/12/2018.
//  Copyright © 2018 Egor Petrov. All rights reserved.
//

import UIKit

protocol TableManager: class {

  var rows: [Row] { get set }

  var isEmpty: Bool { get }

  var tableView: UITableView? { get }

  func connect(to tableView: UITableView, with tableDataSource: TableDataSource.Type, tableDelegate: TableDelegate.Type)

  func append(newRow: Row)
  func append(newRows: [Row])

  func removeAll()

  func reload()
}

class TableManagerImpl: TableManager {

  var rows = [Row]()

  var isEmpty: Bool {
    return rows.isEmpty
  }

  weak var tableView: UITableView?

  private var tableDataSource: TableDataSource?
  private var tableDelegate: TableDelegate?

  func connect(to tableView: UITableView,
               with tableDataSource: TableDataSource.Type,
               tableDelegate: TableDelegate.Type) {
    self.tableView = tableView
    self.tableDataSource = tableDataSource.init(tableManager: self)
    self.tableDelegate = tableDelegate.init(tableManager: self)
  }

  func append(newRow: Row) {
    rows.append(newRow)
  }

  func append(newRows: [Row]) {
    rows.append(contentsOf: newRows)
  }

  func removeAll() {
    rows.removeAll()
  }

  func reload() {
    tableView?.reloadData()
  }
}
