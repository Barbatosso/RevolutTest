//
//  TableRow.swift
//  RevolutTest
//
//  Created by Egor Petrov on 01/12/2018.
//  Copyright © 2018 Egor Petrov. All rights reserved.
//

import UIKit

class TableRow<CellType: ConfigurableCell>: Row, Equatable where CellType: UITableViewCell {

  var reuseId: String {
    return CellType.reuseId
  }

  var cellType: AnyClass {
    return CellType.self
  }

  var onTap: () -> Bool = {
    return true
  }

  let data: CellType.CellData

  init(data: CellType.CellData) {
    self.data = data
  }

  func configure(_ cell: UITableViewCell) {
    (cell as? CellType)?.configure(with: data)
  }

  static func == (lhs: TableRow<CellType>, rhs: TableRow<CellType>) -> Bool {
    return lhs.reuseId == rhs.reuseId
      && lhs.cellType == rhs.cellType
      && lhs.data == rhs.data
  }
}
