//
//  TableDelegate.swift
//  RevolutTest
//
//  Created by Egor Petrov on 01/12/2018.
//  Copyright © 2018 Egor Petrov. All rights reserved.
//

import UIKit

protocol TableDelegate: class {

  init(tableManager: TableManager)
}

class TableDelegateImpl: NSObject, TableDelegate, UITableViewDelegate {

  private weak var tableManager: TableManager?

  required init(tableManager: TableManager) {
    self.tableManager = tableManager

    super.init()

    tableManager.tableView?.delegate = self
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let rows = tableManager?.rows else { return }

    tableView.beginUpdates()
    tableView.moveRow(at: indexPath, to: IndexPath(row: 0, section: indexPath.section))
    tableView.endUpdates()

    if rows[indexPath.row].onTap() {
      tableView.deselectRow(at: indexPath, animated: true)
    }
  }
}
