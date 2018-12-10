//
//  FundsTableRow.swift
//  RevolutTest
//
//  Created by Egor Petrov on 04/12/2018.
//  Copyright © 2018 Egor Petrov. All rights reserved.
//

import UIKit

class FundsTableRow: TableRow<FundsTableViewCell> {

  private let funds: Observable<Currencies>
  var observableText: Observable<String>?
  private let key: String

  init(data: FundsItem, funds: Observable<Currencies>) {
    self.key = data.fundsCode
    self.funds = funds

    super.init(data: data)
  }

  override func configure(_ cell: UITableViewCell) {
    super.configure(cell)

    guard let cell = cell as? FundsTableViewCell else { return }

    funds.observe(cell) { [weak self] item in
      guard let self = self,
            let value = item?.funds,
            let rate =  value.rates[self.key]
      else { return }
      var currencyValue: Double
      if let ratio = item?.value {
        currencyValue = rate * ratio
      } else {
        currencyValue = rate
      }
      cell.setNewFund(currencyValue)
    }

    observableText = cell.observableText()
  }
}
