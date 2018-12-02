//
//  TableDataSource.swift
//  RevolutTest
//
//  Created by Egor Petrov on 01/12/2018.
//  Copyright © 2018 Egor Petrov. All rights reserved.
//

import UIKit

protocol TableDataSource: class {

  init(tableManager: TableManager)
}

class TableDataSourceImpl: NSObject, TableDataSource, UITableViewDataSource {

  private weak var tableManager: TableManager?

  private let cellRegistrar: TableViewCellRegistrar

  required init(tableManager: TableManager) {
    self.tableManager = tableManager
    cellRegistrar = TableViewCellRegistrarImpl(tableView: tableManager.tableView)

    super.init()

    tableManager.tableView?.dataSource = self
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tableManager?.rows.count ?? 0
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let rows = tableManager?.rows else {
      fatalError("\(tableManager.debugDescription) was deallocated")
    }
    let row = rows[indexPath.row]
    cellRegistrar.register(row.cellType, for: row.reuseId)
    let cell = tableView.dequeueReusableCell(withIdentifier: row.reuseId, for: indexPath)
    row.configure(cell)
    return cell
  }
}
