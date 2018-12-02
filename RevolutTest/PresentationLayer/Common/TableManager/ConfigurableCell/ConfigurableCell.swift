//
//  ConfigurableCell.swift
//  RevolutTest
//
//  Created by Egor Petrov on 01/12/2018.
//  Copyright © 2018 Egor Petrov. All rights reserved.
//

import UIKit

protocol ConfigurableCell {

  static var reuseId: String { get }

  associatedtype CellData: Equatable

  func configure(with data: CellData)
}

extension ConfigurableCell where Self: UITableViewCell {

  static var reuseId: String {
    return String(describing: self)
  }
}
