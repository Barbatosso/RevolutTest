//
//  FundsTableRow.swift
//  RevolutTest
//
//  Created by Egor Petrov on 04/12/2018.
//  Copyright © 2018 Egor Petrov. All rights reserved.
//

import UIKit

class FundsTableRow: TableRow<FundsTableViewCell> {

  var observer: ((Double) -> Void)?

  override func configure(_ cell: UITableViewCell) {
    super.configure(cell)

    guard let cell = cell as? FundsTableViewCell else { return }

    observer = { value in
      cell.fundsTextField.text = String(value)
    }
  }
}
