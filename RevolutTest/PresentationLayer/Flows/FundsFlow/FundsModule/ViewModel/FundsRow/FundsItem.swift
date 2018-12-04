//
//  FundsItem.swift
//  RevolutTest
//
//  Created by Egor Petrov on 02/12/2018.
//  Copyright © 2018 Egor Petrov. All rights reserved.
//

import Foundation

struct FundsItem: Equatable {

  let fundsCode: String
  let value: Double

  static func == (lhs: FundsItem, rhs: FundsItem) -> Bool {
    return lhs.fundsCode == rhs.fundsCode
  }
}
