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

  private let tableManager: TableManager
  private let viewModel: FundsViewModel

  init(tableManager: TableManager, viewModel: FundsViewModel) {
    self.tableManager = tableManager
    self.viewModel = viewModel

    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    setupTableManager()
    viewModel.getFunds(with: { [weak self] funds, _ in
      guard let funds = funds else { return }
      self?.bind(funds)
    })
  }

  private func setupTableManager() {
    tableManager.connect(to: rootView.tableView, with: TableDataSourceImpl.self, tableDelegate: TableDelegateImpl.self)
  }

  private func bind(_ funds: FundsType) {
    if tableManager.isEmpty {
      firstTableSetup(with: funds)
    }
  }

  private func firstTableSetup(with funds: FundsType) {
    var rows = funds.rates.map { [unowned self] item -> FundsTableRow in
      let rowItem = FundsItem(fundsCode: item.key, value: item.value)
      let row = FundsTableRow(
        data: rowItem,
        funds: self.viewModel.funds
      )
      configureRowTap(for: row, with: item.key)
      return row
    }
    let rowItem = viewModel.standartRowData
    let row = FundsTableRow(
      data: rowItem,
      funds: self.viewModel.funds
    )
    rows.insert(row, at: 0)
    tableManager.append(newRows: rows)
    tableManager.reload()
    viewModel.viewIsReady(true)
  }

  private func configureRowTap(for row: FundsTableRow, with key: String) {
    row.onTap = { [weak self] in
      guard let self = self else { return true}
      row.observableText?.observeWithUniqueObserver(self) {
        self.viewModel.observeRatio($0)
      }
      self.viewModel.updateCurrencyCode(key)
      return true
    }
  }
}
