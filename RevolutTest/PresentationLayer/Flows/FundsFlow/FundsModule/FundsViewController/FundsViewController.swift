//
//  FundsViewController.swift
//  RevolutTest
//
//  Created by Egor Petrov on 02/12/2018.
//  Copyright © 2018 Egor Petrov. All rights reserved.
//

import UIKit

class FundsViewController: UIViewController, FundsModule, FundsViewModelOutput, ViewHolder {

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
    viewModel.getFunds()
  }

  private func setupTableManager() {
    tableManager.connect(to: rootView.tableView, with: BaseTableDataSource.self, tableDelegate: FundsTableDelegate.self)
  }

  func setupTableView(with rows: [Row]) {
    tableManager.append(newRows: rows)
    tableManager.reload()
    viewModel.viewIsReady(true)
  }
}
