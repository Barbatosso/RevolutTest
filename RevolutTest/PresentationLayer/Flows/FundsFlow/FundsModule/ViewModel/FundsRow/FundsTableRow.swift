//
//  FundsTableRow.swift
//  RevolutTest
//
//  Created by Egor Petrov on 04/12/2018.
//  Copyright © 2018 Egor Petrov. All rights reserved.
//

import UIKit

class FundsTableRow: TableRow<FundsTableViewCell> {

  private let observable: Observable<FundsType>
  private let key: String

  init(data: FundsItem, observable: Observable<FundsType>) {
    self.key = data.fundsCode
    self.observable = observable

    super.init(data: data)
  }

  override func configure(_ cell: UITableViewCell) {
    super.configure(cell)

    guard let cell = cell as? FundsTableViewCell else { return }

    observable.observe(cell) { [weak self] funds in
      guard let self = self,
        let funds = funds,
        let value = funds.rates[self.key]
        else { return }
      cell.setNewFund(value)
    }
  }
}
