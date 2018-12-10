//
//  FundsTableDelegate.swift
//  RevolutTest
//
//  Created by Egor Petrov on 10/12/2018.
//  Copyright © 2018 Egor Petrov. All rights reserved.
//

import UIKit

class FundsTableDelegate: NSObject, TableDelegate, UITableViewDelegate {

  private weak var tableManager: TableManager?

  required init(tableManager: TableManager) {
    self.tableManager = tableManager

    super.init()

    tableManager.tableView?.delegate = self
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard var rows = tableManager?.rows else { return }

    let indexPathForFirstItem = IndexPath(row: 0, section: indexPath.section)
    let firstCell = tableView.cellForRow(at: indexPathForFirstItem)
    firstCell?.resignFirstResponder()

    if rows[indexPath.row].onTap() {
      tableView.deselectRow(at: indexPath, animated: true)
    }

    let cell = tableView.cellForRow(at: indexPath)
    cell?.becomeFirstResponder()

    tableView.beginUpdates()
    tableView.moveRow(at: indexPath, to: indexPathForFirstItem)
    tableView.endUpdates()

    let row = rows.remove(at: indexPath.row)
    rows.insert(row, at: 0)
    tableManager?.rows = rows
  }

  func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    tableManager?.tableView?.visibleCells.first?.resignFirstResponder()
  }
}
