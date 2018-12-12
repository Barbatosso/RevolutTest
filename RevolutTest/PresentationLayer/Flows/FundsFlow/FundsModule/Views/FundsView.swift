//
//  FundsView.swift
//  RevolutTest
//
//  Created by Egor Petrov on 23/10/2018.
//  Copyright © 2018 Egor Petrov. All rights reserved.
//

import UIKit
import SnapKit

class FundsView: UIView {

  let tableView: UITableView = {
    let tableView = UITableView(frame: .zero, style: .plain)
    tableView.estimatedRowHeight = 44
    tableView.rowHeight = UITableView.automaticDimension
    return tableView
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)

    setupInitialLayout()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setupInitialLayout() {
    addSubview(tableView)
    tableView.snp.makeConstraints { make in
      make.top.equalTo(safeOrMarginLayoutGuide)
      make.leading.bottom.trailing.equalToSuperview()
    }
  }
}
