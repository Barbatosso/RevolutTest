//
//  MockTableRow.swift
//  RevolutTestTests
//
//  Created by Egor Petrov on 12/12/2018.
//  Copyright © 2018 Egor Petrov. All rights reserved.
//

import UIKit

class MockTableRow: TableRow<MockConfigurableTableViewCell> {

  var title: String = ""

  override func configure(_ cell: UITableViewCell) {
    super.configure(cell)

    guard let cell = cell as? MockConfigurableTableViewCell else { return }

    title = cell.title
  }
}
