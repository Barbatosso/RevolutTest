//
//  TableViewCellRegistrar.swift
//  RevolutTest
//
//  Created by Egor Petrov on 02/12/2018.
//  Copyright © 2018 Egor Petrov. All rights reserved.
//

import UIKit

protocol TableViewCellRegistrar {

  var registeredIds: Set<String> { get }

  func register(_ cellClass: AnyClass, for reuseId: String)
}

class TableViewCellRegistrarImpl: TableViewCellRegistrar {

  var registeredIds = Set<String>()

  private weak var tableView: UITableView?

  init(tableView: UITableView?) {
    self.tableView = tableView
  }

  func register(_ cellClass: AnyClass, for reuseId: String) {
    guard !registeredIds.contains(reuseId) else { return }

    registeredIds.insert(reuseId)
    tableView?.register(cellClass, forCellReuseIdentifier: reuseId)
  }
}
