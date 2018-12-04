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
    var rows = funds.rates.map { [weak self] item -> TableRow<FundsTableViewCell> in
      let rowItem = FundsItem(fundsCode: item.key, value: item.value)
      let row = FundsTableRow(data: rowItem)
      self?.configureObserver(for: row, with: item.key)
      return row
    }
    let rowItem = viewModel.standartRowData
    let row = FundsTableRow(data: rowItem)
    configureObserver(for: row, with: rowItem.fundsCode)
    rows.insert(row, at: 0)
    tableManager.append(newRows: rows)
    tableManager.reload()
    viewModel.viewIsReady(true)
  }

  private func configureObserver(for row: FundsTableRow, with currencyCode: String) {
    viewModel.addFundsObserver(for: row) { funds in
      guard let funds = funds,
        let value = funds.rates[currencyCode]
        else { return }
      row.observer?(value)
    }
  }
}
