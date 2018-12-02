//
//  FundsViewController.swift
//  RevolutTest
//
//  Created by Egor Petrov on 02/12/2018.
//  Copyright © 2018 Egor Petrov. All rights reserved.
//

import UIKit

class FundsViewController: UIViewController, FundsModule, ViewHolder {

  typealias RootViewType = FundsView

  override func loadView() {
    view = FundsView()
  }

  private func bindFunds(funds: FundsType) {
  }
}
