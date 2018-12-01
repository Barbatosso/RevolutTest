//
//  Row.swift
//  RevolutTest
//
//  Created by Egor Petrov on 01/12/2018.
//  Copyright © 2018 Egor Petrov. All rights reserved.
//

import UIKit

protocol RowConfigurable {

  func configure(_ cell: UITableViewCell)
}

protocol RowActionable {

  var onTap: () -> Bool { get set }
}

protocol RowEquitable {

  func isEqual(to other: Row) -> Bool
}

protocol Row: RowEquitable, RowConfigurable, RowActionable {

  var reuseId: String { get }
  var cellType: AnyClass { get }
}

extension Row where Self: Equatable {

  func isEqual(to other: Row) -> Bool {
    return self == (other as! Self)
  }
}
