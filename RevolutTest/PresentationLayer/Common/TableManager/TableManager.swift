//
//  TableManager.swift
//  RevolutTest
//
//  Created by Egor Petrov on 02/12/2018.
//  Copyright © 2018 Egor Petrov. All rights reserved.
//

import UIKit

protocol TableManager: class {

  var tableView: UITableView? { get }

  func append(newRow: Row)
  func append(newRows: [Row])

  func removeAll()
}

class TableManagerImpl: TableManager {

  private(set) weak var tableView: UITableView?

  func append(newRow: Row) {
  }

  func append(newRows: [Row]) {
  }

  func removeAll() {
  }
}
