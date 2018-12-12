//
//  MockConfigurableTableViewCell.swift
//  RevolutTestTests
//
//  Created by Egor Petrov on 12/12/2018.
//  Copyright © 2018 Egor Petrov. All rights reserved.
//

import UIKit

class MockConfigurableTableViewCell: UITableViewCell, ConfigurableCell {

  var title: String = ""

  func configure(with data: MockCellData) {
    title = data.title
  }
}
